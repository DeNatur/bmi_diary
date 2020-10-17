import 'package:bmi_diary/utils/constants/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuToggleWidget extends StatelessWidget {
  final int index;
  final Function onChanged;
  final String textLeft;
  final String textRight;

  const NeuToggleWidget(
      {Key key,
      @required this.index,
      @required this.onChanged,
      @required this.textLeft,
      @required this.textRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicToggle(
        height: 25,
        selectedIndex: index,
        onChanged: onChanged,
        style:
            NeumorphicToggleStyle(backgroundColor: color_btn_disable, depth: 6),
        children: [
          buildToggleElement(textLeft),
          buildToggleElement(textRight),
        ],
        thumb: Neumorphic(
          style:
              NeumorphicStyle(color: color_btn_able, intensity: 0.3, depth: 6),
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
