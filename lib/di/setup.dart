import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:com.example.moex/features/shares/di_setup.dart'
    as shares_feature;
import 'package:http/io_client.dart';
import 'package:kiwi/kiwi.dart' as di;

di.Container buildDiContainer() {
  final container = di.Container();

  final httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  container.registerSingleton(
    (c) => ChopperClient(
      baseUrl: 'https://iss.com.example.moex.com/',
      client: IOClient(httpClient),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    ),
  );

  shares_feature.registerArtifacts(container);

  return container;
}
