import 'package:bmi_diary/database/database.dart';
import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/generated/locale_base.dart';
import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:stacked/stacked.dart';

class ResultViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseManager _databaseManager = locator<DatabaseManager>();
  BMI bmi;
  final LocaleBase loc;

  void pop() {
    _navigationService.pop();
  }

  ResultViewModel({this.bmi, this.loc});

  Future saveBMI() async {
    if (bmi.id == null) {
      DateTime now = DateTime.now();
      bmi.time = now.millisecondsSinceEpoch;
      bmi = await _databaseManager.insertBMI(bmi);
    } else {
      bmi = await _databaseManager.updateBMI(bmi);
    }
  }

  double getCurrentWeight() {
    return bmi.unitWeight == BMI.UNIT_KG
        ? bmi.weight
        : bmi.weight * BMI.KG_TO_LBS_CONST;
  }

  double getGoalWeight() {
    return bmi.unitWeight == BMI.UNIT_KG
        ? bmi.goal
        : bmi.goal * BMI.KG_TO_LBS_CONST;
  }

  String getFormattedNormalWeight() {
    return bmi.unitWeight == BMI.UNIT_KG
        ? "${BMI.calculateNormalLowerWeight(bmi.height)}-${BMI.calculateNormalUpperWeight(bmi.height)}"
        : "${(double.parse(BMI.calculateNormalLowerWeight(bmi.height)) * BMI.KG_TO_LBS_CONST).toStringAsFixed(1)}-${(double.parse(BMI.calculateNormalUpperWeight(bmi.height)) * BMI.KG_TO_LBS_CONST).toStringAsFixed(1)}";
  }

  Future goToDiary() async {
    if (bmi.id == null) {
      DateTime now = DateTime.now();
      bmi.time = now.millisecondsSinceEpoch;
      bmi = await _databaseManager.insertBMI(bmi);
    } else {
      bmi = await _databaseManager.updateBMI(bmi);
    }
    List<BMI> listBmis = await _databaseManager.getBMIS();
    _navigationService.navigateTo(DiaryViewRoute, arguments: listBmis);
  }
}
