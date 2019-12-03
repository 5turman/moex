import 'package:chopper/chopper.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:timezone/data/latest.dart';

import 'build.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();

  if (Build.debug) {
    _enableHttpLogging();
  }
}

void _enableHttpLogging() {
  chopperLogger.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
