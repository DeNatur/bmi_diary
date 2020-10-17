import 'dart:developer';

import 'package:bmi_diary/database/database.dart';
import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

enum TimeType {
  Week,
  Month,
  Year,
}

class DiaryViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseManager _databaseManager = locator<DatabaseManager>();
  TimeType timeType = TimeType.Week;
  int selectedKgOrLbs = 0;
  List<BMI> bmiList;

  void setKgOrLbs(int v) {
    this.selectedKgOrLbs = v;
    notifyListeners();
  }

  double getHighestValue() {
    double highestValue = 0;
    for (BMI b in bmiList) {
      if (b.weight > highestValue) {
        highestValue = b.weight;
      }
    }
    if (selectedKgOrLbs == BMI.UNIT_KG)
      return highestValue;
    else
      return highestValue * BMI.KG_TO_LBS_CONST;
  }

  void setTimeTipe(TimeType timeType) {
    this.timeType = timeType;
    notifyListeners();
  }

  double getLastDesiredWeight() {
    return bmiList.isNotEmpty ? bmiList.last.goal : 0;
  }

  double getCurrentWeight() {
    return bmiList.isNotEmpty ? bmiList.last.weight : 0;
  }

  String getCurrentWeightDiff() {
    double desiredWeight = getLastDesiredWeight();
    double currentWeight = getCurrentWeight();

    double diff = desiredWeight - currentWeight;
    if (diff > 0) {
      if (selectedKgOrLbs == BMI.UNIT_KG)
        return "+ ${diff.toStringAsPrecision(3)} kg remain";
      else
        return "+ ${(diff * BMI.KG_TO_LBS_CONST).toStringAsPrecision(3)} lbs remain";
    } else if (diff < 0) {
      if (selectedKgOrLbs == BMI.UNIT_KG)
        return "+ ${(diff * -1).toStringAsPrecision(3)} kg remain";
      else
        return "+ ${(diff * -1 * BMI.KG_TO_LBS_CONST).toStringAsPrecision(3)} lbs remain";
    } else
      return "Goal reached!";
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
        return _getYearFormatedValue(value);
        break;
    }
  }

  String _getYearFormatedValue(int value) {
    switch (value) {
      case 1:
        return DateFormat('dd.MM.yyyy')
            .format(DateTime.now().subtract(Duration(days: 366)));
      case 121:
        return DateFormat('dd.MM.yyyy')
            .format(DateTime.now().subtract(Duration(days: 243)));
      case 241:
        return DateFormat('dd.MM.yyyy')
            .format(DateTime.now().subtract(Duration(days: 121)));
      case 361:
        return DateFormat('dd.MM.yyyy').format(DateTime.now());
      default:
        return '';
    }
  }

  String _getMonthFormatedValue(int value) {
    switch (value) {
      case 1:
        return DateFormat('dd.MM')
            .format(DateTime.now().subtract(Duration(days: 28)));
      case 7:
        return DateFormat('dd.MM')
            .format(DateTime.now().subtract(Duration(days: 21)));
      case 14:
        return DateFormat('dd.MM')
            .format(DateTime.now().subtract(Duration(days: 14)));
      case 21:
        return DateFormat('dd.MM')
            .format(DateTime.now().subtract(Duration(days: 7)));
      case 28:
        return DateFormat('dd.MM').format(DateTime.now());
      default:
        return '';
    }
  }

  void deleteBMI(BMI bmi) {
    _databaseManager.deleteBMI(bmi);
    bmiList.remove(bmi);
    notifyListeners();
  }

  void goToCalculatorPage() {
    _navigationService.navigateTo(CalculatorViewRoute);
  }

  String _getWeekFormatedValue(int value) {
    return DateFormat('dd.MM')
        .format(DateTime.now().subtract(Duration(days: 7 - value)));
  }

  List<FlSpot> getListOfWeightBarDataBeforTime() {
    List<FlSpot> listOfWeightBatData = List();
    DateTime timeBeginDay = DateTime.now();
    DateTime timeEndDay = DateTime.now();
    timeBeginDay = timeBeginDay.subtract(Duration(
        days: timeType == TimeType.Week
            ? 6
            : timeType == TimeType.Month ? 27 : 364));

    timeBeginDay =
        DateTime(timeBeginDay.year, timeBeginDay.month, timeBeginDay.day);
    timeEndDay = DateTime(
        timeBeginDay.year, timeBeginDay.month, timeBeginDay.day, 23, 59, 0);

    int endLoop =
        timeType == TimeType.Week ? 7 : timeType == TimeType.Month ? 28 : 365;

    for (int i = 1; i <= endLoop; i++) {
      for (BMI bmi in bmiList) {
        if (bmi.time >= timeBeginDay.millisecondsSinceEpoch &&
            bmi.time <= timeEndDay.millisecondsSinceEpoch) {
          if (selectedKgOrLbs == BMI.UNIT_KG)
            listOfWeightBatData.add(FlSpot(i.toDouble(), bmi.weight));
          else
            listOfWeightBatData
                .add(FlSpot(i.toDouble(), bmi.weight * BMI.KG_TO_LBS_CONST));
        }
      }

      timeBeginDay = timeBeginDay.add(Duration(days: 1));
      timeEndDay = timeEndDay.add(Duration(days: 1));
    }
    return listOfWeightBatData;
  }

  DiaryViewModel({this.bmiList}) {
    bmiList.sort((a, b) => b.time.compareTo(a.time));
  }

  void pop() {
    _navigationService.pop();
  }
}
