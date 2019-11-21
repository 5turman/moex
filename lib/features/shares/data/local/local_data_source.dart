import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:com.example.moex/db/database_provider.dart';
import 'package:com.example.moex/db/shares_table.dart';
import 'package:com.example.moex/features/shares/data/shares_data_source.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource extends SharesDataSource {
  final DatabaseProvider _databaseProvider;

  LocalDataSource(this._databaseProvider);

  @override
  Future<BuiltList<Share>> getAll() async {
    final db = await _databaseProvider.get();
    final rows = await db.query(
      SharesTable.name,
      columns: SharesTable.allColumns,
    );

    return BuiltList.of(rows.map((row) => row.toShare()));
  }

  @override
  Future putAll(BuiltList<Share> shares) async {
    final db = await _databaseProvider.get();
    final batch = db.batch();

    for (final share in shares) {
      batch.insert(
        SharesTable.name,
        share.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return batch.commit(noResult: true);
  }
}

extension ShareExtension on Share {
  Map<String, dynamic> toMap() => {
        SharesColumn.id: id,
        SharesColumn.shortName: shortName,
        SharesColumn.timestamp: timestamp,
        SharesColumn.last: last,
        SharesColumn.lastToPrev: lastToPrev,
      };
}

extension MapExtension on Map<String, dynamic> {
  Share toShare() => Share(
        id: this[SharesColumn.id],
        shortName: this[SharesColumn.shortName],
        timestamp: this[SharesColumn.timestamp],
        last: this[SharesColumn.last],
        lastToPrev: this[SharesColumn.lastToPrev],
      );
}
