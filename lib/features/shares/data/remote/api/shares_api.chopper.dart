// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shares_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SharesApi extends SharesApi {
  _$SharesApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SharesApi;

  Future<Response<BuiltList<Share>>> getShares() {
    final $url = 'iss/engines/stock/markets/shares/boards/TQBR/securities.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<Share>, Share>($request,
        responseConverter: convertSharesResponse);
  }
}
