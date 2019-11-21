class SharesTable {
  static const name = 'shares';

  static const createSql = '''
    CREATE TABLE shares (
      id TEXT PRIMARY KEY,
      short_name TEXT,
      timestamp INTEGER,
      last FLOAT,
      last_to_prev FLOAT
    );
  ''';

  static const allColumns = [
    SharesColumn.id,
    SharesColumn.shortName,
    SharesColumn.timestamp,
    SharesColumn.last,
    SharesColumn.lastToPrev,
  ];
}

class SharesColumn {
  static const id = 'id';
  static const shortName = 'short_name';
  static const timestamp = 'timestamp';
  static const last = 'last';
  static const lastToPrev = 'last_to_prev';
}
