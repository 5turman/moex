import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/core/extensions/collection_ext.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:com.example.moex/features/shares/domain/shares_repository.dart';

import 'shares_data_source.dart';

class SharesRepositoryImpl extends SharesRepository {
  final SharesDataSource _localDataSource;
  final SharesDataSource _remoteDataSource;

  SharesRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<BuiltList<Share>> getShares(bool refreshing) async {
    if (!refreshing) {
      final localShares = await _localDataSource.getAll();
      if (!localShares.isNullOrEmpty) {
        return localShares;
      }
    }
    return _remoteDataSource.getAll().then((shares) {
      _localDataSource.putAll(shares);
      return shares;
    });
  }
}
