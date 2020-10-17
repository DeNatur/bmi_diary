import 'package:bmi_diary/database/models/bmi.dart';
import 'package:bmi_diary/diary/diary_viewmodel.dart';
import 'package:bmi_diary/generated/locale_base.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:bmi_diary/utils/widgets/bmi_tile.dart';
import 'package:bmi_diary/utils/widgets/toggle_element.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_sinusoidals/flutter_sinusoidals.dart';
import 'package:stacked/stacked.dart';

class DiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiaryViewModel>.reactive(
        viewModelBuilder: () => DiaryViewModel(
            bmiList: ModalRoute.of(context).settings.arguments,
            loc: Localizations.of<LocaleBase>(context, LocaleBase)),
        builder: (context, model, child) => Scaffold(
              appBar: NeumorphicAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BMI",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    Text(
                      " " + model.loc.diary.diary,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
                    )
                  ],
                ),
                actions: [Container()],
                leading: NeumorphicButton(
                  onPressed: model.pop,
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: color_btn_able,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: NeumorphicFloatingActionButton(
                  style: NeumorphicStyle(
                    color: color_orange,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.grey[200],
                  ),
                  onPressed: model.goToCalculatorPage),
              body: ListView(physics: BouncingScrollPhysics(), children: [
                SizedBox(
                  height: 16,
                ),
                _buildDateTypeChooser(model),
                SizedBox(
                  height: 16,
                ),
                _buildChart(model),
                buildNeumorphicLegend(model),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(flex: 1, child: buildGoalWidget(model)),
                      Flexible(flex: 1, child: buildCurrentWeightWidget(model)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.bmiList.length,
                        itemBuilder: (context, position) {
                          return BMITile(
                              kgOrLbs: model.selectedKgOrLbs,
                              onDeletePress: () {
                                buildDeleteDialog(
                                    context, model, model.bmiList[position]);
                              },
                              bmi: model.bmiList[position],
                              previousWeight:
                                  position < model.bmiList.length - 1
                                      ? model.bmiList[position + 1].weight
                                      : model.bmiList[position].weight);
                        })),
                SizedBox(
                  height: 64,
                ),
              ]),
            ));
  }

  Neumorphic _buildChart(DiaryViewModel model) {
    return Neumorphic(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LineChart(sampleData1(model)),
      ),
    );
  }

  Row _buildDateTypeChooser(DiaryViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
            flex: 1,
            child: _getTimeTypeTile(
                model.loc.diary.week, model.timeType != TimeType.Week, () {
              model.setTimeTipe(TimeType.Week);
            })),
        Flexible(
            flex: 1,
            child: _getTimeTypeTile(
                model.loc.diary.month, model.timeType != TimeType.Month, () {
              model.setTimeTipe(TimeType.Month);
            })),
        Flexible(
            flex: 1,
            child: _getTimeTypeTile(
                model.loc.diary.year, model.timeType != TimeType.Year, () {
              model.setTimeTipe(TimeType.Year);
            })),
      ],
    );
  }

  Future<bool> buildDeleteDialog(
      BuildContext context, DiaryViewModel model, BMI bmi) {
    return showDialog(
        context: context,
        child: AlertDialog(
          backgroundColor: Colors.grey[200],
          insetPadding: EdgeInsets.all(16),
          title: Text(
            model.loc.diary.dialog_delete_content,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black54),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(bottom: 8, right: 16),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  model.notifyListeners();
                },
                child: Text(
                  model.loc.diary.cancel,
                  style: TextStyle(
                      color: Colors.black38, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8, right: 16),
              child: MaterialButton(
                onPressed: () {
                  model.deleteBMI(bmi);
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  model.loc.diary.delete,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ));
  }

  Container buildCurrentWeightWidget(DiaryViewModel model) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(left: 16),
      child: Neumorphic(
        style: NeumorphicStyle(depth: 6, color: color_orange, intensity: 0.5),
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CombinedWave(
                    reverse: true,
                    models: const [
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 5,
                        translate: 25,
                        frequency: 0.5,
                      ),
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 3,
                        translate: 7.5,
                        frequency: 1.5,
                      ),
                    ],
                    child: Container(height: 30, color: color_darker_orange),
                  ),
                  CombinedWave(
                    reverse: false,
                    models: const [
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 2,
                        translate: 3.2,
                        frequency: 0.5,
                      ),
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 4,
                        translate: 1.5,
                        frequency: 1.5,
                      ),
                    ],
                    child: Container(
                      height: 30,
                      color: color_darker_orange,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 24, left: 16),
                      child: Text(model.loc.diary.current_weight,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.white))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                            model.selectedKgOrLbs == BMI.UNIT_KG
                                ? model.getCurrentWeight().toStringAsFixed(1)
                                : (model.getCurrentWeight() *
                                        BMI.KG_TO_LBS_CONST)
                                    .toStringAsFixed(1),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                      Center(
                        child: Text(model.getCurrentWeightDiff(),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Center(
                        child: Text(
                            model.loc.diary.fat +
                                ": ${model.getCurrentFat().toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildGoalWidget(DiaryViewModel model) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(right: 16),
      child: Neumorphic(
        style:
            NeumorphicStyle(depth: 6, color: Colors.grey[300], intensity: 0.5),
        child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CombinedWave(
                    reverse: true,
                    models: const [
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 5,
                        translate: 25,
                        frequency: 0.5,
                      ),
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 3,
                        translate: 7.5,
                        frequency: 1.5,
                      ),
                    ],
                    child: Container(
                      height: 30,
                      color: Colors.grey[400],
                    ),
                  ),
                  CombinedWave(
                    reverse: false,
                    models: const [
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 4,
                        translate: 4.2,
                        frequency: 0.5,
                      ),
                      SinusoidalModel(
                        amplitude: 10,
                        waves: 2,
                        translate: 2.5,
                        frequency: 1.5,
                      ),
                    ],
                    child: Container(
                      height: 30,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 24, left: 16),
                      child: Text(model.loc.diary.goal,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.black54))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                            model.selectedKgOrLbs == BMI.UNIT_KG
                                ? model
                                    .getLastDesiredWeight()
                                    .toStringAsFixed(1)
                                : (model.getLastDesiredWeight() *
                                        BMI.KG_TO_LBS_CONST)
                                    .toStringAsFixed(1),
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                      ),
                      Center(
                        child: Text(
                            model.selectedKgOrLbs == BMI.UNIT_KG ? "kg" : "lbs",
                            style: TextStyle(
                              color: Colors.black54.withOpacity(0.3),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Neumorphic buildNeumorphicLegend(DiaryViewModel model) {
    return Neumorphic(
      margin: EdgeInsets.only(left: 32, right: 32, top: 0),
      child: Container(
        margin: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 4,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: color_normal),
                        ),
                        Text(
                          model.loc.diary.weight,
                          style:
                              TextStyle(color: color_txt_disable, fontSize: 12),
                        )
                      ],
                    )),
                Flexible(flex: 1, child: Container()),
                Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 2,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: color_orange),
                        ),
                        Text(
                          model.loc.diary.desired_weight,
                          style:
                              TextStyle(color: color_txt_disable, fontSize: 12),
                        )
                      ],
                    ))
              ],
            ),
            Container(
              width: 100,
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              child: NeuToggleWidget(
                  index: model.selectedKgOrLbs,
                  onChanged: model.setKgOrLbs,
                  textLeft: "kg",
                  textRight: "lbs"),
            )
          ],
        ),
      ),
    );
  }

  Widget _getTimeTypeTile(String txt, bool isPressed, Function onPressed) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        color: isPressed ? color_orange : color_orange.withOpacity(0.6),
        depth: isPressed ? 6 : -20,
        intensity: isPressed ? 0.4 : 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      child: Container(
        width: 60,
        height: 24,
        alignment: Alignment.centerRight,
        child: Container(
            alignment: Alignment.center,
            child: Text(
              txt,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            )),
      ),
    );
  }

  LineChartData sampleData1(DiaryViewModel model) {
    List<FlSpot> flSpots = model.getListOfWeightBarDataBeforTime();
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: color_txt_disable,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            return model.getFormattedValue(value.toInt());
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: color_txt_disable,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            if (model.selectedKgOrLbs == BMI.UNIT_KG) {
              if (value.toInt() % 20 == 0) {
                return value.toInt().toString() + " kg";
              }
            } else {
              if (value.toInt() % 30 == 0) {
                return value.toInt().toString() + " lb";
              }
            }
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: const Border(
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: model.timeType == TimeType.Week
          ? 7
          : model.timeType == TimeType.Month ? 28 : 365,
      maxY: model.getHighestValue() + 20,
      minY: 0,
      lineBarsData: linesBarData1(model, flSpots),
    );
  }

  List<LineChartBarData> linesBarData1(
      DiaryViewModel model, List<FlSpot> flSpots) {
    final LineChartBarData weightBarData = LineChartBarData(
      spots: flSpots.isEmpty
          ? [
              FlSpot(1, 0),
            ]
          : flSpots,
      isCurved: true,
      colors: [
        color_normal,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData desiredWeightBarData = LineChartBarData(
      spots: [
        FlSpot(1, model.getLastDesiredWeight()),
        FlSpot(
            model.timeType == TimeType.Week
                ? 7
                : model.timeType == TimeType.Month ? 30 : 365,
            model.getLastDesiredWeight())
      ],
      isCurved: true,
      colors: [
        color_orange,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
      ),
    );
    return [
      desiredWeightBarData,
      weightBarData,
    ];
  }
}
