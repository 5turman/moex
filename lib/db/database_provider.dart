import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'shares_table.dart';

class DatabaseProvider {
  static const _dbName = 'main.db';
  static const _dbVersion = 1;

  final _lock = Lock();
  Database _db;

  Future<Database> get() async {
    if (_db == null) {
      await _lock.synchronized(
        () async {
          _db = await openDatabase(
            _dbName,
            version: _dbVersion,
            onCreate: _onCreate,
          );
        },
      );
    }
    return _db;
  }

  FutureOr<void> _onCreate(Database db, int version) {
    return db.execute(SharesTable.createSql);
  }
}
