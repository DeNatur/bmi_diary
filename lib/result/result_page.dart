import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/result/result_viewmodel.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stacked/stacked.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResultViewModel>.reactive(
        viewModelBuilder: () =>
            ResultViewModel(bmi: ModalRoute.of(context).settings.arguments),
        builder: (context, model, child) => Scaffold(
              backgroundColor: color_bg,
              appBar: NeumorphicAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BMI",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(
                      " Result",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
                    )
                  ],
                ),
                actions: [
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    onPressed: model.pop,
                    child: Icon(
                      Icons.save,
                      color: color_btn_able,
                    ),
                  )
                ],
                leading: NeumorphicButton(
                  style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                  onPressed: model.pop,
                  child: Icon(
                    Icons.refresh,
                    color: color_btn_able,
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.convex,
                                    boxShape: NeumorphicBoxShape.circle()),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Column(
                                    children: [
                                      Flexible(
                                          flex: 1,
                                          child: Container(
                                            color: model.bmi.dangerousColor
                                                .withOpacity(0.8),
                                          )),
                                      Flexible(
                                          flex: 1,
                                          child: Container(
                                            color: model.bmi.dangerousColor
                                                .withOpacity(0.4),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              alignment: Alignment.topCenter,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                    depth: -20,
                                    boxShape: NeumorphicBoxShape.circle()),
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: NeumorphicText(
                                    model.bmi.result.toStringAsFixed(1),
                                    textStyle: NeumorphicTextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                    style: NeumorphicStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Neumorphic(
                    margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 400,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.bmi.weight.toStringAsFixed(1),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: model.bmi.dangerousColor),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Current weight, kg",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${BMI.calculateNormalLowerWeight(model.bmi.height)}-${BMI.calculateNormalUpperWeight(model.bmi.height)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple[200]),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Normal weight, kg",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    model.bmi.goal.toStringAsFixed(1),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Desired weight, kg",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
