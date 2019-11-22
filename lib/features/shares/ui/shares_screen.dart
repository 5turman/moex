import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/core/async_result.dart';
import 'package:com.example.moex/core/command/command.dart';
import 'package:com.example.moex/core/command/command_handler.dart';
import 'package:com.example.moex/core/widgets/timezone_change_notifier.dart';
import 'package:com.example.moex/di/view_model_provider.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:com.example.moex/generated/i18n.dart';
import 'package:flutter/material.dart';

import 'share_list_tile.dart';
import 'shares_vm.dart';

class SharesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SharesVm>(
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, SharesVm viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shares),
      ),
      body: CommandHandler(
        commands: viewModel.commands(),
        handler: _handleCommand,
        child: AsyncResultListenableBuilder<BuiltList<Share>>(
          listenable: viewModel.shares(),
          builder: (context, asyncResult, child) {
            // Rebuild the widget tree when the time zone is changed
            TimeZoneChangeNotifier.attach(context);

            return asyncResult.when(
              isLoading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              isValue: (shares) {
                return RefreshIndicator(
                  onRefresh: viewModel.onRefresh,
                  child: ListView.builder(
                    itemCount: shares.length,
                    itemBuilder: (context, index) {
                      return ShareListTile(shares[index]);
                    },
                  ),
                );
              },
              isError: (error) {
                // TODO show error view
                return Center(
                  child: GestureDetector(
                    onTap: viewModel.onReload,
                    child: const Text('Error'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _handleCommand(BuildContext context, Command command) {
    if (command is ShowSnackBar) {
      final snackBar = SnackBar(
        content: Text(command.message(context)),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
