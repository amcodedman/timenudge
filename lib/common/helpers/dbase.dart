import 'package:sqflite/sqflite.dart' as sql;
import 'package:timenudge/common/models/shedule.dart';

class DBHelper {
  static Future<void> createTables(sql.Database DB) async {
    await DB.execute("CREATE TABLE Todo ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " title STRING, desc TEXT, data STRING,"
        "starttime STRING, endtime STRING,"
        "reminder INTEGER ,repeat STRING,"
        "iscomplete INTEGER)");

    await DB.execute("CREATE TABLE User ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
        "verify INTEGER)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('timenudge', version: 1,
        onCreate: (sql.Database dbs, int version) async {
      await createTables(dbs);
    });
  }

  static Future<void> CreateItem(Shedule shedule) async {}
}
