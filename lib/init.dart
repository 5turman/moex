import 'package:chopper/chopper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart';

import 'build.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadTimeZones();

  if (Build.debug) {
    _enableHttpLogging();
  }
}

Future _loadTimeZones() async {
  const asset = 'res/tz/2019c.tzf';
  final byteData = await rootBundle.load(asset);
  initializeDatabase(byteData.buffer.asUint8List());
}

void _enableHttpLogging() {
  chopperLogger.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
