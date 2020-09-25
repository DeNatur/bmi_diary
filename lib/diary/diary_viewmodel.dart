import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../main.dart';

class DiaryViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  List<BMI> bmiList;

  DiaryViewModel({this.bmiList});

  void pop() {
    _navigationService.pop();
  }
}
