import 'dart:async';
import 'package:bmi_diary/database/models/dao/bmi_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/bmi.dart';

class DatabaseManager {
  final bmiDao = BMIDao();
  DatabaseProvider databaseProvider;

  DatabaseManager({this.databaseProvider});

  Future<BMI> deleteUser(BMI bmi) async {
    final db = await databaseProvider.db();
    await db.delete(bmiDao.tableName,
        where: bmiDao.columnId + " = ?", whereArgs: [bmi.id]);
    return bmi;
  }

  Future<BMI> getBMIWithId(int id) async {
    final db = await databaseProvider.db();
    String sql =
        "SELECT * FROM ${bmiDao.tableName} WHERE ${bmiDao.columnId} = $id";
    List<Map> maps = await db.rawQuery(sql);
    return maps.length > 0 ? bmiDao.fromList(maps)[0] : null;
  }

  Future<BMI> updateBMI(BMI bmi) async {
    final db = await databaseProvider.db();
    await db.update(bmiDao.tableName, bmiDao.toMap(bmi),
        where: bmiDao.columnId + " = ?", whereArgs: [bmi.id]);
    return bmi;
  }

  Future<List<BMI>> getBMIS() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(bmiDao.tableName);
    return bmiDao.fromList(maps);
  }
}

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "bmi_diary.db");

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(BMIDao().createTableQuery);
    });
  }
}
