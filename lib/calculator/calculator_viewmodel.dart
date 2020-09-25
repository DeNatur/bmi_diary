import 'dart:developer';

import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:flutter/widgets.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:stacked/stacked.dart';

class CalculatorViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Rect rect;
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();

  int selectedGenderIndex = 0;
  int selectedCmOrFt = 0;
  int selectedKgOrLbs = 0;
  TextEditingController heightEditingController =
      TextEditingController(text: "150");
  TextEditingController weightEditingController =
      TextEditingController(text: "50");
  TextEditingController goalEditingController =
      TextEditingController(text: "50");
  TextEditingController ageEditingController =
      TextEditingController(text: "18");

  CalculatorViewModel({this.rectGetterKey});
  void selectCMorFT(int i) {
    selectedCmOrFt = i;
    notifyListeners();
  }

  void selectKgorLbs(int i) {
    selectedKgOrLbs = i;
    notifyListeners();
  }

  void selectGender(int i) {
    selectedGenderIndex = i;
    notifyListeners();
  }

  void onAddHeight() {
    int height = int.parse(heightEditingController.text);
    height++;
    heightEditingController.text = height.toString();
  }

  void onSubtractHeight() {
    int height = int.parse(heightEditingController.text);
    height--;
    heightEditingController.text = height.toString();
  }

  void onAddAge() {
    int height = int.parse(ageEditingController.text);
    height++;
    ageEditingController.text = height.toString();
  }

  void onSubtractAge() {
    int height = int.parse(ageEditingController.text);
    height--;
    ageEditingController.text = height.toString();
  }

  void onAddWeight() {
    double weight = double.parse(weightEditingController.text);
    weight += 0.1;
    weightEditingController.text = weight.toStringAsFixed(1);
  }

  void onSubtractWeight() {
    double weight = double.parse(weightEditingController.text);
    weight -= 0.1;
    weightEditingController.text = weight.toStringAsFixed(1);
  }

  void onAddGoal() {
    double weight = double.parse(goalEditingController.text);
    weight += 0.1;
    goalEditingController.text = weight.toStringAsFixed(1);
  }

  void onSubtractGoal() {
    double weight = double.parse(goalEditingController.text);
    weight -= 0.1;
    goalEditingController.text = weight.toStringAsFixed(1);
  }

  void onCalculatePress() {
    double height = double.parse(heightEditingController.text);
    double weight = double.parse(weightEditingController.text);
    BMI bmi = BMI.from(weight, height);
    bmi.age = int.parse(ageEditingController.text);
    bmi.gender = selectedGenderIndex;
    bmi.goal = double.parse(goalEditingController.text);
    _navigationService.navigateTo(ResultViewRoute, arguments: bmi);
  }
}
