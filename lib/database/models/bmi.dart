import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BMI {
  static int MALE = 0;
  static int FEMALE = 0;

  static const int VERY_SERIOUS_UNDERWEIGHT = 0;
  static const int SERIOUS_UNDERWEIGHT = 1;
  static const int UNDERWEIGHT = 2;
  static const int NORMAL = 3;
  static const int OVERWEIGHT = 4;
  static const int OBESITY_I = 5;
  static const int OBESITY_II = 6;

  int id;
  int time;
  int gender;
  double height;
  double weight;
  double goal;
  int age;
  double result;
  int type;
  Color dangerousColor;

  BMI(
      {this.id,
      this.height,
      this.gender,
      this.weight,
      this.time,
      this.goal,
      this.age,
      this.result});

  static String calculateNormalLowerWeight(double height) {
    return (18.5 * (height / 100 * height / 100)).toStringAsFixed(1);
  }

  static String calculateNormalUpperWeight(double height) {
    return (24.9 * (height / 100 * height / 100)).toStringAsFixed(1);
  }

  static Color getDangerousColor(int result) {
    switch (result) {
      case OBESITY_II:
        return color_very_serious;
      case VERY_SERIOUS_UNDERWEIGHT:
        return color_very_serious;
      case OBESITY_I:
        return color_serious;
      case SERIOUS_UNDERWEIGHT:
        return color_serious;
      case OVERWEIGHT:
        return color_wrong;
      case UNDERWEIGHT:
        return color_wrong;
      case NORMAL:
        return color_normal;
      default:
        return Colors.amberAccent;
    }
  }

  static int getType(double result) {
    if (result <= 16) {
      return VERY_SERIOUS_UNDERWEIGHT;
    } else if (result > 16 && result <= 16.9) {
      return SERIOUS_UNDERWEIGHT;
    } else if (result > 16.9 && result <= 18.4) {
      return UNDERWEIGHT;
    } else if (result > 18.4 && result <= 24.9) {
      return NORMAL;
    } else if (result > 24.9 && result <= 29.9) {
      return OVERWEIGHT;
    } else if (result > 29.9 && result <= 34.9) {
      return OBESITY_I;
    } else {
      return OBESITY_II;
    }
  }

  static BMI from(double weight, double height) {
    BMI bmi = new BMI(weight: weight, height: height);
    bmi.result = BMI.calculateBMI(weight, height);
    bmi.type = BMI.getType(bmi.result);
    bmi.dangerousColor = BMI.getDangerousColor(bmi.type);
    return bmi;
  }

  static double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }
}
