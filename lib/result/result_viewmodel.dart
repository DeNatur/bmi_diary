import 'package:bmi_diary/database/database.dart';
import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/services/navigation_service.dart';
import 'package:bmi_diary/utils/constants/route_names.dart';
import 'package:stacked/stacked.dart';

class ResultViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseManager _databaseManager = locator<DatabaseManager>();
  BMI bmi;

  void pop() {
    _navigationService.pop();
  }

  ResultViewModel({this.bmi});

  Future saveBMI() async {
    if (bmi.id == null) {
      DateTime now = DateTime.now();
      bmi.time = now.millisecondsSinceEpoch;
      bmi = await _databaseManager.insertBMI(bmi);
    } else {
      bmi = await _databaseManager.updateBMI(bmi);
    }
  }

  Future goToDiary() async {
    List<BMI> listBmis = await _databaseManager.getBMIS();
    _navigationService.navigateTo(DiaryViewRoute, arguments: listBmis);
  }
}
