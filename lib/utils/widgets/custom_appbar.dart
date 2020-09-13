import 'package:bmi_diary/main.dart';
import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CalculatorAppBar extends PreferredSize {
  String title;
  String btnText;
  Function onPressed;

  CalculatorAppBar({this.title, this.btnText, this.onPressed});

  @override
  final Size preferredSize = Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: topPadding + 24),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
            child: NeumorphicButton(
              onPressed: onPressed,
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                color: color_orange,
                depth: 6,
                intensity: 0.4,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              ),
              child: Container(
                width: 60,
                height: 24,
                alignment: Alignment.centerRight,
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      btnText,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    )),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                ),
                Text("BMI",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                Text(
                  " " + title,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
