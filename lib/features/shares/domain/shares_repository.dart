import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';

abstract class SharesRepository {
  Future<BuiltList<Share>> getShares(bool refreshing);
}
