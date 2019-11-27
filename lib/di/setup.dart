import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:com.example.moex/di/object_graph.dart';
import 'package:com.example.moex/features/shares/di_setup.dart'
    as shares_feature;
import 'package:http/io_client.dart';

import 'kiwi_object_graph.dart';

ObjectGraph buildObjectGraph() {
  final objectGraph = KiwiObjectGraph();

  final httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  objectGraph.registerLazySingleton(
    (r) => ChopperClient(
      baseUrl: 'https://iss.com.example.moex.com/',
      client: IOClient(httpClient),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    ),
  );

  shares_feature.registerArtifacts(objectGraph);

  return objectGraph;
}
