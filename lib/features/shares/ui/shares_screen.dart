import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/core/async_result.dart';
import 'package:com.example.moex/core/command/command.dart';
import 'package:com.example.moex/core/command/command_handler.dart';
import 'package:com.example.moex/core/widgets/adaptive_widgets.dart';
import 'package:com.example.moex/core/widgets/timezone_change_notifier.dart';
import 'package:com.example.moex/di/view_model_provider.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:com.example.moex/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../build.dart';
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
    return PageScaffold(
      title: S.of(context).shares,
      child: CommandHandler(
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
              isValue: (shares) => _buildList(context, viewModel, shares),
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

  Widget _buildList(
    BuildContext context,
    SharesVm viewModel,
    BuiltList<Share> shares,
  ) {
    if (Build.isIOS) {
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverRefreshControl(
              onRefresh: viewModel.onRefresh,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return ShareListTile(shares[index]);
                },
                childCount: shares.length,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      child: ListView.builder(
        itemCount: shares.length,
        itemBuilder: (context, index) {
          return ShareListTile(shares[index]);
        },
      ),
    );
  }

  void _handleCommand(BuildContext context, Command command) {
    if (command is ShowSnackBar) {
      final snackBar = SnackBar(
        content: Text(command.message(context)),
      );
      // TODO show error on iOS
      if (!Build.isIOS) {
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }
}
