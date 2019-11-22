import 'package:async/async.dart';
import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/core/async_result.dart';
import 'package:com.example.moex/core/command/command.dart';
import 'package:com.example.moex/core/command/command_store.dart';
import 'package:com.example.moex/core/extensions/collection_ext.dart';
import 'package:com.example.moex/core/extensions/future_ext.dart';
import 'package:com.example.moex/core/resource_text.dart';
import 'package:com.example.moex/core/view_model.dart';
import 'package:com.example.moex/errors.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:com.example.moex/features/shares/domain/shares_repository.dart';

class SharesVm extends ViewModel {
  SharesVm(this._sharesRepository) : assert(_sharesRepository != null);

  final SharesRepository _sharesRepository;

  final _sharesNotifier = AsyncResultNotifier<BuiltList<Share>>();
  final _commands = CommandStore();

  CancelableOperation _loadSharesOperation;

  var _isFirstAttach = true;

  AsyncResultListenable<BuiltList<Share>> shares() {
    if (_isFirstAttach) {
      _isFirstAttach = false;
      _loadShares(false);
    }
    return _sharesNotifier;
  }

  Stream<Command> commands() => _commands.asStream();

  Future onRefresh() {
    return _loadShares(true);
  }

  Future onReload() {
    _sharesNotifier.setLoading();
    return _loadShares(false);
  }

  @override
  void dispose() {
    _loadSharesOperation?.cancel();
    _commands.close();
  }

  Future _loadShares(bool refreshing) {
    _loadSharesOperation = _sharesRepository
        .getShares(refreshing)
        .toCancelableOperation()
        .then((shares) => shares.sort(_compareByShortName))
        .then(
      _sharesNotifier.setValue,
      onError: (error, st) {
        print(error);
        print(st);
        if (refreshing) {
          _commands.add(ShowSnackBar(error.getMessage()));
        } else {
          _sharesNotifier.setError(error);
        }
      },
    );

    return _loadSharesOperation.value;
  }
}

int _compareByShortName(Share a, Share b) => a.shortName.compareTo(b.shortName);

class ShowSnackBar extends Command {
  ShowSnackBar(this.message) : assert(message != null);

  final ResourceText message;
}
