import 'package:bmi_diary/diary/diary_viewmodel.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stacked/stacked.dart';

class DiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiaryViewModel>.reactive(
        viewModelBuilder: () =>
            DiaryViewModel(bmiList: ModalRoute.of(context).settings.arguments),
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
                      " Diary",
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
                child: Icon(Icons.add),
                onPressed: () {},
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LineChart(sampleData1(model)),
                  )
                ],
              ),
            ));
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
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return model.getFormattedValue(value.toInt());
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            if (value.toInt() % 20 == 0) {
              return value.toString();
            }
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
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
          : model.timeType == TimeType.Month ? 30 : 365,
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
        const Color(0xff4af699),
      ],
      barWidth: 8,
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
    return [weightBarData, desiredWeightBarData];
  }
}
