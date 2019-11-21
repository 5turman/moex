import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:timezone/timezone.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadTimeZones();

  if (!kReleaseMode) {
    _enableHttpLogging();
  }
}

Future _loadTimeZones() async {
  final asset = 'res/tz/2019c.tzf';
  final byteData = await rootBundle.load(asset);
  initializeDatabase(byteData.buffer.asUint8List());
}

void _enableHttpLogging() {
  chopperLogger.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
