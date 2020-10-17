import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocaleBase {
  Map<String, dynamic> _data;
  String _path;
  Future<void> load(String path) async {
    _path = path;
    final strJson = await rootBundle.loadString(path);
    _data = jsonDecode(strJson);
    initAll();
  }
  
  Map<String, String> getData(String group) {
    return Map<String, String>.from(_data[group]);
  }

  String getPath() => _path;

  Localemain _main;
  Localemain get main => _main;
  Localecalculator _calculator;
  Localecalculator get calculator => _calculator;
  Localeresult _result;
  Localeresult get result => _result;
  Localediary _diary;
  Localediary get diary => _diary;

  void initAll() {
    _main = Localemain(Map<String, String>.from(_data['main']));
    _calculator = Localecalculator(Map<String, String>.from(_data['calculator']));
    _result = Localeresult(Map<String, String>.from(_data['result']));
    _diary = Localediary(Map<String, String>.from(_data['diary']));
  }
}

class Localemain {
  final Map<String, String> _data;
  Localemain(this._data);

  
}
class Localecalculator {
  final Map<String, String> _data;
  Localecalculator(this._data);

  String get male => _data["male"];
  String get female => _data["female"];
  String get calculator => _data["calculator"];
  String get diary => _data["diary"];
  String get goal => _data["goal"];
  String get age => _data["age"];
  String get calculate => _data["calculate"];
}
class Localeresult {
  final Map<String, String> _data;
  Localeresult(this._data);

  String get result => _data["result"];
  String get current_weight => _data["current_weight"];
  String get normal_weight => _data["normal_weight"];
  String get desired_weight => _data["desired_weight"];
  String get very_serious_underweight => _data["very_serious_underweight"];
  String get serious_underweight => _data["serious_underweight"];
  String get underweight => _data["underweight"];
  String get normal => _data["normal"];
  String get overweight => _data["overweight"];
  String get obesity1 => _data["obesity1"];
  String get obesity2 => _data["obesity2"];
  String get fat => _data["fat"];
  String get saved_bmi => _data["saved_bmi"];
}
class Localediary {
  final Map<String, String> _data;
  Localediary(this._data);

  String get diary => _data["diary"];
  String get week => _data["week"];
  String get month => _data["month"];
  String get year => _data["year"];
  String get weight => _data["weight"];
  String get desired_weight => _data["desired_weight"];
  String get goal => _data["goal"];
  String get current_weight => _data["current_weight"];
  String get remain => _data["remain"];
  String get fat => _data["fat"];
  String get dialog_delete_content => _data["dialog_delete_content"];
  String get cancel => _data["cancel"];
  String get delete => _data["delete"];
  String get goal_reached => _data["goal_reached"];
}
