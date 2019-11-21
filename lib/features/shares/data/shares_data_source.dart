import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';

abstract class SharesDataSource {
  Future<BuiltList<Share>> getAll();

  Future putAll(BuiltList<Share> shares);
}
