import 'package:meta/meta.dart';

class Share {
  Share({
    @required this.id,
    this.shortName,
    this.timestamp,
    this.last,
    this.lastToPrev,
  }) : assert(id != null);

  final String id;
  final String shortName;
  final int timestamp;
  final double last;
  final double lastToPrev;

  @override
  String toString() =>
      'Share(id=$id, shortName=$shortName, timestamp=$timestamp, last=$last, lastToPrev=$lastToPrev)';
}
