import 'dart:math';

import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class BMITile extends StatelessWidget {
  final BMI bmi;
  final int kgOrLbs;
  final double previousWeight;
  final Function onDeletePress;
  const BMITile(
      {Key key,
      @required this.bmi,
      @required this.kgOrLbs,
      @required this.previousWeight,
      @required this.onDeletePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE')
                      .format(DateTime.fromMillisecondsSinceEpoch(bmi.time)),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  DateFormat('MMMM dd')
                      .format(DateTime.fromMillisecondsSinceEpoch(bmi.time)),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      kgOrLbs == BMI.UNIT_KG
                          ? bmi.weight.toStringAsFixed(1)
                          : (bmi.weight * BMI.KG_TO_LBS_CONST)
                              .toStringAsFixed(1),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    kgOrLbs == BMI.UNIT_KG ? "kg" : "lbs",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                bmi.weight >= bmi.goal
                    ? bmi.weight > previousWeight
                        ? Transform.rotate(
                            angle: pi * -0.25,
                            child: Icon(
                              Icons.arrow_forward,
                              color: color_very_serious,
                            ),
                          )
                        : bmi.weight < previousWeight
                            ? Transform.rotate(
                                angle: pi * 0.25,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: color_green,
                                ),
                              )
                            : Text(
                                "-",
                                style:
                                    TextStyle(fontSize: 32, color: Colors.grey),
                              )
                    : bmi.weight > previousWeight
                        ? Transform.rotate(
                            angle: pi * -0.25,
                            child: Icon(
                              Icons.arrow_forward,
                              color: color_normal,
                            ),
                          )
                        : Transform.rotate(
                            angle: pi * -0.25,
                            child: Icon(
                              Icons.arrow_forward,
                              color: color_very_serious,
                            ),
                          ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  kgOrLbs == BMI.UNIT_KG
                      ? ((bmi.weight - previousWeight)).toStringAsFixed(1)
                      : ((bmi.weight - previousWeight) * BMI.KG_TO_LBS_CONST)
                          .toStringAsFixed(1),
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    onPressed: onDeletePress,
                  )))
        ],
      ),
    );
  }
}
