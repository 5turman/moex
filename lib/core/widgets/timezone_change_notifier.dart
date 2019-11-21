import 'dart:ui';

import 'package:flutter/widgets.dart';

class TimeZoneChangeDetector extends StatefulWidget {
  final Widget child;

  const TimeZoneChangeDetector({Key key, this.child}) : super(key: key);

  @override
  _TimeZoneChangeDetectorState createState() => _TimeZoneChangeDetectorState();
}

class _TimeZoneChangeDetectorState extends State<TimeZoneChangeDetector>
    with WidgetsBindingObserver {
  String _currentTimeZone;

  @override
  void initState() {
    super.initState();
    _currentTimeZone = _timeZone();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final timeZone = _timeZone();
      if (timeZone != _currentTimeZone) {
        setState(() {
          _currentTimeZone = timeZone;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TimeZoneChangeNotifier(
      timeZone: _currentTimeZone,
      child: widget.child,
    );
  }

  String _timeZone() => DateTime.now().timeZoneName;
}

class TimeZoneChangeNotifier extends InheritedWidget {
  final String timeZone;

  const TimeZoneChangeNotifier({
    Key key,
    @required this.timeZone,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(TimeZoneChangeNotifier oldWidget) =>
      (timeZone != oldWidget.timeZone);

  static void attach(BuildContext context) {
    context.inheritFromWidgetOfExactType(TimeZoneChangeNotifier);
  }
}
