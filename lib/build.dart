import 'dart:io';

import 'package:flutter/foundation.dart';

class Build {
  Build._noInstance();

  static final isIOS = Platform.isIOS;
  static const debug = kDebugMode;
}
