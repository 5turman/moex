import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:com.example.moex/features/shares/data/remote/api/shares_deserializer.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';

part 'shares_api.chopper.dart';

@ChopperApi()
abstract class SharesApi extends ChopperService {
  static SharesApi create([ChopperClient client]) => _$SharesApi(client);

  @Get(path: 'iss/engines/stock/markets/shares/boards/TQBR/securities.json')
  @FactoryConverter(response: convertSharesResponse)
  Future<Response<BuiltList<Share>>> getShares();
}

Response convertSharesResponse<T>(Response response) {
  final json = jsonDecode(response.body);
  final shares = SharesDeserializer.deserialize(json);
  return response.replace(body: shares);
}
