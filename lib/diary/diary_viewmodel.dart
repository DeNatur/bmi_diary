import 'dart:developer';

import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

enum TimeType {
  Week,
  Month,
  Year,
}

class DiaryViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TimeType timeType = TimeType.Week;
  List<BMI> bmiList;

  double getHighestValue() {
    double highestValue = 0;
    for (BMI b in bmiList) {
      if (b.weight > highestValue) {
        highestValue = b.weight;
      }
    }
    return highestValue;
  }

  double getLastDesiredWeight() {
    return bmiList.last.goal;
  }

  String getFormattedValue(int value) {
    switch (timeType) {
      case TimeType.Week:
        return _getWeekFormatedValue(value);
        break;
      case TimeType.Month:
        return _getMonthFormatedValue(value);
        break;
      default:
        _getYearFormatedValue(value);
        break;
    }
  }

  String _getYearFormatedValue(int value) {
    switch (value) {
      case 31:
        return 'JAN';
      case 43:
        return '2 week';
      case 21:
        return '3 week';
      case 30:
        return '4 week';
      default:
        return '';
    }
  }

  String _getMonthFormatedValue(int value) {
    switch (value) {
      case 7:
        return '1 week';
      case 14:
        return '2 week';
      case 21:
        return '3 week';
      case 30:
        return '4 week';
      default:
        return '';
    }
  }

  String _getWeekFormatedValue(int value) {
    switch (value) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
    }
    return '';
  }

  List<FlSpot> getListOfWeightBarDataBeforTime() {
    List<FlSpot> listOfWeightBatData = List();
    DateTime time = DateTime.now();
    time = time.subtract(Duration(
        days: timeType == TimeType.Week
            ? 7
            : timeType == TimeType.Month ? 30 : 365));
    time = DateTime(time.year, time.month, time.day);
    for (BMI bmi in bmiList) {
      if (bmi.time >= time.millisecondsSinceEpoch) {
        log("${(bmi.time - time.millisecondsSinceEpoch).toDouble() / 100000000}");
        listOfWeightBatData.add(new FlSpot(
            (bmi.time - time.millisecondsSinceEpoch).toDouble() / 100000000,
            bmi.weight));
      }
    }
    log("l: ${listOfWeightBatData.length} + counter ${listOfWeightBatData[0].y}");
    return listOfWeightBatData;
  }

  DiaryViewModel({this.bmiList});

  void pop() {
    _navigationService.pop();
  }
}
