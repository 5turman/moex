import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../build.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    @required this.title,
    @required this.child,
    this.resizeToAvoidBottomInset = true,
  })  : assert(title != null),
        assert(child != null);

  final String title;
  final Widget child;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    if (Build.isIOS) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
        ),
        child: child,
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(title: Text(title)),
      body: child,
    );
  }
}
