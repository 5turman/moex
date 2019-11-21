import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:timezone/timezone.dart';

class SharesDeserializer {
  static const _idKey = 'SECID';

  static Location _serverLocation;

  static BuiltList<Share> deserialize(Map json) {
    final securityProjection = _buildProjection(json['securities']['columns']);
    final dataProjection = _buildProjection(json['marketdata']['columns']);

    final securities = _buildSecurities(
      json['securities']['data'] as List,
      securityProjection,
    );

    var iterable = (json['marketdata']['data'] as List).map((e) {
      final data = e as List;
      final id = data[dataProjection[_idKey]] as String;
      final security = securities[id];
      return Share(
        id: id,
        shortName: security[securityProjection['SHORTNAME']],
        timestamp: _buildTime(data, dataProjection),
        last: _toDouble(data[dataProjection['LAST']]),
        lastToPrev: _toDouble(data[dataProjection['LASTTOPREVPRICE']]),
      );
    });

    return BuiltList(iterable);
  }

  static Map<String, List> _buildSecurities(
      List data, Map<String, int> projection) {
    final securities = Map<String, List>();
    for (List d in data) {
      final id = d[projection[_idKey]] as String;
      securities[id] = d;
    }
    return securities;
  }

  static Map<String, int> _buildProjection(List<dynamic> allColumns) {
    final map = Map<String, int>();
    for (int i = 0; i < allColumns.length; ++i) {
      final column = allColumns[i] as String;
      map[column] = i;
    }
    return map;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return null;
  }

  static int _buildTime(List<dynamic> data, Map<String, int> projection) {
    if (_serverLocation == null) {
      _serverLocation = getLocation('Europe/Moscow');
    }

    final String sysDateTime = data[projection['SYSTIME']];
    final String time = data[projection['TIME']];

    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(sysDateTime);
    final hms = time.split(':');

    final tzDateTime = TZDateTime(
      _serverLocation,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hms[0].toInt(),
      hms[1].toInt(),
      hms[2].toInt(),
    );

    return tzDateTime.millisecondsSinceEpoch;
  }
}

extension _StringExtension on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}
