import 'dart:async';

import 'command.dart';

class CommandStore {
  final _controller = StreamController<Command>();

  Stream<Command> _stream;

  void add(Command command) {
    _controller.add(command);
  }

  Stream<Command> asStream() {
    if (_stream == null) {
      _stream = _controller.stream.asBroadcastStream(
        onListen: (subscription) {
          subscription.resume();
        },
        onCancel: (subscription) {
          subscription.pause();
        },
      );
    }
    return _stream;
  }

  void close() {
    _controller.close();
  }
}
