import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/features/shares/data/shares_data_source.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';

import 'api/shares_api.dart';

class RemoteDataSource extends SharesDataSource {
  RemoteDataSource(this._api) : assert(_api != null);

  final SharesApi _api;

  @override
  Future<BuiltList<Share>> getAll() {
    return _api.getShares().then((response) => response.body);
  }

  @override
  Future putAll(BuiltList<Share> shares) {
    throw UnsupportedError('putAll');
  }
}
