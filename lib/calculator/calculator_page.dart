import 'dart:async';

import 'package:bmi_diary/calculator/calculator_viewmodel.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:bmi_diary/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stacked/stacked.dart';

class CalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalculatorViewModel>.reactive(
        viewModelBuilder: () => CalculatorViewModel(),
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: color_bg,
              appBar: CalculatorAppBar(
                title: "Calculator",
                btnText: "DIARY",
                onPressed: model.goToDiaryPage,
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 42,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: NeuButton(
                                  onPressed: () {
                                    model.selectGender(0);
                                  },
                                  text: "Male",
                                  icon: Icons.accessible_forward,
                                  depth:
                                      model.selectedGenderIndex == 0 ? 6 : -20,
                                  btnColor: model.selectedGenderIndex == 0
                                      ? color_btn_able
                                      : color_btn_disable,
                                  txtColor: model.selectedGenderIndex == 0
                                      ? Colors.white
                                      : color_txt_disable,
                                )),
                            Flexible(
                                flex: 1,
                                child: NeuButton(
                                  onPressed: () {
                                    model.selectGender(1);
                                  },
                                  text: "Female",
                                  icon: Icons.accessibility_new,
                                  depth:
                                      model.selectedGenderIndex == 1 ? 6 : -20,
                                  btnColor: model.selectedGenderIndex == 1
                                      ? color_btn_able
                                      : color_btn_disable,
                                  txtColor: model.selectedGenderIndex == 1
                                      ? Colors.white
                                      : color_txt_disable,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 42),
                                  child: NeumorphicToggle(
                                      height: 25,
                                      selectedIndex: model.selectedCmOrFt,
                                      onChanged: model.selectCMorFT,
                                      style: NeumorphicToggleStyle(
                                          backgroundColor: color_btn_disable,
                                          depth: 6),
                                      children: [
                                        buildToggleElement("cm"),
                                        buildToggleElement("ft"),
                                      ],
                                      thumb: Neumorphic(
                                        style: NeumorphicStyle(
                                            color: color_btn_able,
                                            intensity: 0.3,
                                            depth: 6),
                                      )),
                                )),
                            Flexible(
                              child: BuildChooser(
                                onPressedRight: model.onAddHeight,
                                onPressedLeft: model.onSubtractHeight,
                                textEditingController:
                                    model.heightEditingController,
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 42),
                                  child: NeumorphicToggle(
                                      height: 25,
                                      selectedIndex: model.selectedKgOrLbs,
                                      onChanged: model.selectKgorLbs,
                                      style: NeumorphicToggleStyle(
                                          backgroundColor: color_btn_disable,
                                          depth: 6),
                                      children: [
                                        buildToggleElement("kg"),
                                        buildToggleElement("lbs"),
                                      ],
                                      thumb: Neumorphic(
                                        style: NeumorphicStyle(
                                            color: color_btn_able,
                                            intensity: 0.3,
                                            depth: 6),
                                      )),
                                )),
                            Flexible(
                              child: BuildChooser(
                                onPressedRight: model.onAddWeight,
                                onPressedLeft: model.onSubtractWeight,
                                textEditingController:
                                    model.weightEditingController,
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 42),
                                    child: Text(
                                      "goal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ))),
                            Flexible(
                              child: BuildChooser(
                                onPressedRight: model.onAddGoal,
                                onPressedLeft: model.onSubtractGoal,
                                textEditingController:
                                    model.goalEditingController,
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 42),
                                    child: Text(
                                      "age",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ))),
                            Flexible(
                              child: BuildChooser(
                                onPressedRight: model.onAddAge,
                                onPressedLeft: model.onSubtractAge,
                                textEditingController:
                                    model.ageEditingController,
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ],
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        model.onCalculatePress();
                      },
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 32),
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
                          "CALCULATE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  ToggleElement buildToggleElement(String txt) {
    return ToggleElement(
      background: Center(
        child: Text(
          txt,
          style: TextStyle(color: color_txt_disable, fontSize: 10),
        ),
      ),
      foreground: Center(
        child: Text(
          txt,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

class BuildChooser extends StatefulWidget {
  Function onPressedLeft;
  Function onPressedRight;
  var difference = 1;
  TextEditingController textEditingController;

  BuildChooser(
      {this.onPressedLeft, this.onPressedRight, this.textEditingController});

  @override
  _BuildChooserState createState() => _BuildChooserState();
}

class _BuildChooserState extends State<BuildChooser> {
  bool isLeftPressed = false;
  bool isRightPressed = false;
  Timer timerLeft;
  Timer timerRight;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          children: [
            NeumorphicButton(
              onPressed: () {},
              margin: EdgeInsets.all(3),
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: color_btn_able,
                depth: isLeftPressed ? -20 : 6,
                intensity: 0.3,
                shape: NeumorphicShape.convex,
              ),
              child: Container(
                height: isLeftPressed ? 8 : 10,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, top: 10),
              child: Icon(
                Icons.remove,
                size: 16,
                color: color_bg,
              ),
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                widget.onPressedLeft();
                isLeftPressed = true;
                setState(() {});
                timerLeft = Timer.periodic(Duration(milliseconds: 100), (t) {
                  widget.onPressedLeft();
                });
              },
              onTapUp: (TapUpDetails details) {
                timerLeft.cancel();
                setState(() {
                  isLeftPressed = false;
                });
              },
              onTapCancel: () {
                timerLeft.cancel();
                setState(() {
                  isLeftPressed = false;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                color: Colors.transparent,
                width: 40,
              ),
            ),
          ],
        ),
        Container(
          width: 80,
          alignment: Alignment.center,
          child: NeumorphicTextField(
            textEditingController: widget.textEditingController,
          ),
        ),
        Stack(
          children: [
            NeumorphicButton(
              onPressed: widget.onPressedRight,
              margin: EdgeInsets.all(3),
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: color_btn_able,
                depth: isRightPressed ? -20 : 6,
                intensity: 0.3,
                shape: NeumorphicShape.convex,
              ),
              child: Container(
                height: isRightPressed ? 8 : 10,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, top: 10),
              child: Icon(
                Icons.add,
                size: 16,
                color: color_bg,
              ),
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                widget.onPressedRight();
                isRightPressed = true;
                setState(() {});
                timerRight = Timer.periodic(Duration(milliseconds: 100), (t) {
                  widget.onPressedRight();
                });
              },
              onTapUp: (TapUpDetails details) {
                isRightPressed = false;
                setState(() {});
                timerRight.cancel();
              },
              onTapCancel: () {
                isRightPressed = false;
                setState(() {});
                timerRight.cancel();
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                color: Colors.transparent,
                width: 40,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NeumorphicTextField extends StatelessWidget {
  TextEditingController textEditingController;
  NeumorphicTextField({Key key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        color: color_btn_disable,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
        depth: NeumorphicTheme.embossDepth(context),
      ),
      child: Container(
          height: 42,
          margin: EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          child: TextField(
            controller: textEditingController,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration.collapsed(hintText: ""),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          )),
    );
  }
}

class NeuButton extends StatelessWidget {
  String text;
  Function onPressed;
  double depth;
  Color btnColor;
  Color txtColor;
  IconData icon;

  NeuButton(
      {this.text,
      this.onPressed,
      this.depth,
      this.btnColor,
      this.txtColor,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: EdgeInsets.all(16),
      onPressed: onPressed,
      provideHapticFeedback: false,
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: depth,
        intensity: 0.4,
        lightSource: LightSource.topLeft,
        color: btnColor,
      ),
      child: Container(
          height: 120,
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: txtColor,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: TextStyle(
                  color: txtColor,
                ),
              )
            ],
          )),
    );
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;

  _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: this.widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.widget.hint),
          ),
        )
      ],
    );
  }
}
