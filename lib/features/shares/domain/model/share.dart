class Share {
  Share({
    this.id,
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

  String toString() =>
      'Share(id=$id, shortName=$shortName, timestamp=$timestamp, last=$last, lastToPrev=$lastToPrev)';
}
