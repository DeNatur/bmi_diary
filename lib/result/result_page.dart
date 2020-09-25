import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/result/result_viewmodel.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stacked/stacked.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  var _animationTime = 2000;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: _animationTime))
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: pi, end: 4 * pi).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.bounceOut));
    _animationController.forward();
  }

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
                  Builder(
                    builder: (ctx) => NeumorphicButton(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text("Saved BMI",
                              style: TextStyle(
                                color: color_btn_able,
                              )),
                          backgroundColor: Colors.black38,
                        );
                        Scaffold.of(ctx).showSnackBar(snackBar);
                        model.saveBMI();
                      },
                      child: Icon(
                        Icons.save,
                        color: color_btn_able,
                      ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Transform.rotate(
                              angle: _animation.value,
                              child: Container(
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
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Very serious underweight",
                                style: TextStyle(
                                    fontSize: 12, color: color_very_serious),
                              ),
                              Text(
                                "Under 16",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Serious underweight",
                                style: TextStyle(
                                    fontSize: 12, color: color_serious),
                              ),
                              Text(
                                "16.0 - 16.9",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Underweight",
                                style:
                                    TextStyle(fontSize: 12, color: color_wrong),
                              ),
                              Text(
                                "17.0 - 18.4",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Normal",
                                style: TextStyle(
                                    fontSize: 12, color: color_normal),
                              ),
                              Text(
                                "18.5 - 24.9",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Overweight",
                                style:
                                    TextStyle(fontSize: 12, color: color_wrong),
                              ),
                              Text(
                                "25.0 - 29.9",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Obesity grade I",
                                style: TextStyle(
                                    fontSize: 12, color: color_serious),
                              ),
                              Text(
                                "30.0 - 34.9",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Obrsity grade II",
                                style: TextStyle(
                                    fontSize: 12, color: color_very_serious),
                              ),
                              Text(
                                "35.0 - 39.9",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      model.goToDiary();
                    },
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 62),
                    style: NeumorphicStyle(
                        color: color_orange,
                        depth: 6,
                        intensity: 0.3,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12))),
                    child: Container(
                      height: 24,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "DIARY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
