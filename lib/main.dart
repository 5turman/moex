import 'package:com.example.moex/core/widgets/timezone_change_notifier.dart';
import 'package:com.example.moex/di/object_graph.dart';
import 'package:com.example.moex/di/setup.dart';
import 'package:com.example.moex/features/shares/ui/shares_screen.dart';
import 'package:com.example.moex/generated/i18n.dart';
import 'package:com.example.moex/init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'build.dart';

// ignore: avoid_void_async
void main() async {
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final supportedLocales = S.delegate.supportedLocales;

    final localizationsDelegates = <LocalizationsDelegate>[
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];

    final localeResolutionCallback = S.delegate.resolution(
      fallback: const Locale('en', ''),
      withCountry: false,
    );

    String onGenerateTitle(BuildContext context) => S.of(context).app_title;

    return Provider<ObjectResolver>.value(
      value: buildObjectGraph(),
      child: Build.isIOS
          ? CupertinoApp(
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              localeResolutionCallback: localeResolutionCallback,
              onGenerateTitle: onGenerateTitle,
              home: TimeZoneChangeDetector(
                child: SharesScreen(),
              ),
            )
          : MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              localeResolutionCallback: localeResolutionCallback,
              onGenerateTitle: onGenerateTitle,
              home: TimeZoneChangeDetector(
                child: SharesScreen(),
              ),
            ),
    );
  }
}
