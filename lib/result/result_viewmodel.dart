import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class ResultViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BMI bmi;

  void pop() {
    _navigationService.pop();
  }

  ResultViewModel({this.bmi});
}
