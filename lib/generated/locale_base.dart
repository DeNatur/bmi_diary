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

  void initAll() {
    _main = Localemain(Map<String, String>.from(_data['main']));
    _calculator = Localecalculator(Map<String, String>.from(_data['calculator']));
    _result = Localeresult(Map<String, String>.from(_data['result']));
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
}
