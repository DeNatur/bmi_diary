import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/database/models/dao/dao.dart';

class BMIDao extends Dao<BMI> {
  final tableName = 'bmis';
  final columnId = 'id';
  final _columnGender = 'gender';
  final _columnWeight = 'weight';
  final _columnHeight = 'height';
  final _columnTime = 'time';
  final _columnGoal = 'goal';
  final _columnAge = 'age';
  final _columnResult = 'result';
  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $_columnGender INTEGER,"
      " $_columnHeight REAL,"
      " $_columnWeight REAL,"
      " $_columnGoal REAL,"
      " $_columnTime INTEGER,"
      " $_columnResult REAL,"
      " $_columnAge INTEGER)";

  @override
  List<BMI> fromList(List<Map<String, dynamic>> query) {
    List<BMI> bmis = List<BMI>();
    for (Map map in query) {
      bmis.add(fromMap(map));
    }
    return bmis;
  }

  @override
  BMI fromMap(Map<String, dynamic> query) {
    return BMI(
        id: query[columnId],
        gender: query[_columnGender],
        height: query[_columnHeight],
        weight: query[_columnWeight],
        goal: query[_columnGoal],
        time: query[_columnTime],
        result: query[_columnResult],
        age: query[_columnAge]);
  }

  @override
  Map<String, dynamic> toMap(BMI object) {
    return <String, dynamic>{
      columnId: object.id,
      _columnGender: object.gender,
      _columnHeight: object.height,
      _columnWeight: object.weight,
      _columnGoal: object.goal,
      _columnTime: object.time,
      _columnResult: object.result,
      _columnAge: object.age
    };
  }
}
