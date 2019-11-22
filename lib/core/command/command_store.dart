import 'dart:async';

import 'command.dart';

class CommandStore {
  final _controller = StreamController<Command>();

  Stream<Command> _stream;

  void add(Command command) {
    _controller.add(command);
  }

  Stream<Command> asStream() {
    return _stream ??= _controller.stream.asBroadcastStream(
      onListen: (subscription) {
        subscription.resume();
      },
      onCancel: (subscription) {
        subscription.pause();
      },
    );
  }

  void close() {
    _controller.close();
  }
}
