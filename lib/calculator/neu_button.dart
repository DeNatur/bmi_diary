import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double depth;
  final Color btnColor;
  final Color txtColor;
  final IconData icon;

  NeuButton(
      {required this.text,
      required this.onPressed,
      required this.depth,
      required this.btnColor,
      required this.txtColor,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: EdgeInsets.all(16),
      onPressed: onPressed as void Function()?,
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
