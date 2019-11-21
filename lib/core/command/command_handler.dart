import 'dart:async';

import 'package:flutter/widgets.dart';

import 'command.dart';

typedef AsyncCommandHandler = void Function(
  BuildContext context,
  Command command,
);

class CommandHandler extends StatefulWidget {
  const CommandHandler({
    Key key,
    @required this.commands,
    @required this.handler,
    this.child,
  })  : assert(commands != null),
        assert(handler != null),
        super(key: key);

  final Stream<Command> commands;
  final AsyncCommandHandler handler;
  final Widget child;

  @override
  _CommandHandlerState createState() => _CommandHandlerState();
}

class _CommandHandlerState extends State<CommandHandler> {
  StreamSubscription<Command> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(CommandHandler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.commands != widget.commands) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox(width: 0, height: 0);
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.commands.listen((command) {
      widget.handler(context, command);
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }
}
