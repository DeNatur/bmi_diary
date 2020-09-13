import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class CalculatorViewModel extends BaseViewModel {
  int selectedGenderIndex = 0;
  int selectedCmOrFt = 0;
  int selectedKgOrLbs = 0;
  TextEditingController heightEditingController =
      TextEditingController(text: "100");
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController goalEditingController = TextEditingController();
  TextEditingController ageEditingController = TextEditingController();

  CalculatorViewModel() {
    weightEditingController.text = "50.0";
    goalEditingController.text = "50.0";
    ageEditingController.text = "18";
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
}
