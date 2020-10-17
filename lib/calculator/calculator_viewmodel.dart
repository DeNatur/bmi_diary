import 'dart:developer';

import 'package:bmi_diary/database/database.dart';
import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/generated/locale_base.dart';
import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:stacked/stacked.dart';

class CalculatorViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseManager _databaseManager = locator<DatabaseManager>();
  final LocaleBase loc;
  Rect rect;
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  List<BMI> listBMIs;
  int selectedGenderIndex = 0;
  int selectedCmOrFt = 0;
  int selectedKgOrLbs = 0;
  TextEditingController heightEditingController =
      TextEditingController(text: "150");
  TextEditingController inchesEditingController =
      TextEditingController(text: "0");
  TextEditingController weightEditingController =
      TextEditingController(text: "50");
  TextEditingController goalEditingController =
      TextEditingController(text: "50");
  TextEditingController ageEditingController =
      TextEditingController(text: "18");

  CalculatorViewModel({this.rectGetterKey, this.loc}) {
    setBusy(true);
    _databaseManager.getBMIS().then((value) {
      listBMIs = value;
      if (listBMIs.isNotEmpty) {
        BMI lastBMI = listBMIs.last;
        selectedGenderIndex = lastBMI.gender;
        selectedCmOrFt = lastBMI.unitHeight;
        selectedKgOrLbs = lastBMI.unitWeight;
        ageEditingController.text = lastBMI.age.toString();

        if (selectedKgOrLbs == BMI.UNIT_LBS) {
          weightEditingController.text =
              (lastBMI.weight * BMI.KG_TO_LBS_CONST).toStringAsFixed(1);
          goalEditingController.text =
              (lastBMI.goal * BMI.KG_TO_LBS_CONST).toStringAsFixed(1);
        } else {
          weightEditingController.text = lastBMI.weight.toStringAsFixed(1);
          goalEditingController.text = lastBMI.goal.toStringAsFixed(1);
        }
        if (selectedCmOrFt == BMI.UNIT_FT) {
          double inches = lastBMI.height / BMI.CM_TO_FT_CONST;
          heightEditingController.text = (inches ~/ 12).toString();
          inchesEditingController.text =
              (inches - (12 * double.parse(heightEditingController.text)))
                  .toStringAsFixed(0);
        } else {
          heightEditingController.text = lastBMI.height.toStringAsFixed(0);
        }
      }
      setBusy(false);
    });
  }
  void selectCMorFT(int i) {
    selectedCmOrFt = i;
    double height = double.parse(heightEditingController.text);
    double inches = double.parse(inchesEditingController.text);
    if (i == BMI.UNIT_CM) {
      heightEditingController.text =
          (height * (BMI.CM_TO_FT_CONST * 12) + inches * BMI.CM_TO_FT_CONST)
              .toStringAsFixed(0);
    } else {
      double inches = height / BMI.CM_TO_FT_CONST;
      heightEditingController.text = (inches ~/ 12).toString();
      inchesEditingController.text =
          (inches - (12 * int.parse(heightEditingController.text)))
              .toStringAsFixed(0);
    }
    notifyListeners();
  }

  Future goToDiaryPage() async {
    _navigationService.navigateTo(DiaryViewRoute, arguments: listBMIs);
  }

  void selectKgorLbs(int i) {
    selectedKgOrLbs = i;
    double weight = double.parse(weightEditingController.text);
    if (i == BMI.UNIT_KG)
      weightEditingController.text =
          (weight / BMI.KG_TO_LBS_CONST).toStringAsFixed(1);
    else
      weightEditingController.text =
          (weight * BMI.KG_TO_LBS_CONST).toStringAsFixed(1);

    notifyListeners();
  }

  void selectGender(int i) {
    selectedGenderIndex = i;
    notifyListeners();
  }

  void onAddInch() {
    int height = int.parse(inchesEditingController.text);
    if (height < 12) {
      height++;
      inchesEditingController.text = height.toString();
    }
  }

  void onSubtractInch() {
    int height = int.parse(inchesEditingController.text);
    if (height > 0) {
      height--;
      inchesEditingController.text = height.toString();
    }
  }

  void onAddHeight() {
    int height = int.parse(heightEditingController.text);
    height++;
    heightEditingController.text = height.toString();
  }

  void onSubtractHeight() {
    int height = int.parse(heightEditingController.text);
    if (height > 0) {
      height--;
      heightEditingController.text = height.toString();
    }
  }

  void onAddAge() {
    int height = int.parse(ageEditingController.text);

    height++;
    ageEditingController.text = height.toString();
  }

  void onSubtractAge() {
    int height = int.parse(ageEditingController.text);
    if (height > 0) {
      height--;
      ageEditingController.text = height.toString();
    }
  }

  void onAddWeight() {
    double weight = double.parse(weightEditingController.text);
    weight += 0.1;
    weightEditingController.text = weight.toStringAsFixed(1);
  }

  void onSubtractWeight() {
    double weight = double.parse(weightEditingController.text);
    if (weight > 0) {
      weight -= 0.1;
      weightEditingController.text = weight.toStringAsFixed(1);
    }
  }

  void onAddGoal() {
    double weight = double.parse(goalEditingController.text);
    weight += 0.1;
    goalEditingController.text = weight.toStringAsFixed(1);
  }

  void onSubtractGoal() {
    double weight = double.parse(goalEditingController.text);
    if (weight > 0) {
      weight -= 0.1;
      goalEditingController.text = weight.toStringAsFixed(1);
    }
  }

  void onCalculatePress() {
    double height = double.parse(heightEditingController.text);
    double weight = double.parse(weightEditingController.text);
    if (selectedKgOrLbs == BMI.UNIT_FT) weight = weight / BMI.KG_TO_LBS_CONST;
    if (selectedCmOrFt == BMI.UNIT_FT) {
      double inches = double.parse(inchesEditingController.text);
      height = height * (BMI.CM_TO_FT_CONST * 12) + inches * BMI.CM_TO_FT_CONST;
    }
    BMI bmi = BMI.from(weight, height);
    bmi.age = int.parse(ageEditingController.text);
    bmi.gender = selectedGenderIndex;
    bmi.goal = double.parse(goalEditingController.text);
    bmi.unitHeight = selectedCmOrFt;
    bmi.unitWeight = selectedKgOrLbs;
    bmi.fat = bmi.calculateFat();
    _navigationService.navigateTo(ResultViewRoute, arguments: bmi);
  }
}
