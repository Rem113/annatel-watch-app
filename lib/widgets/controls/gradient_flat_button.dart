import 'package:flutter/material.dart';

class GradientFlatButton extends StatelessWidget {
  final double borderRadius;
  final double fontSize;
  final Gradient gradient;
  final Function onPressed;
  final String text;

  const GradientFlatButton({
    Key key,
    this.borderRadius = 0.0,
    this.fontSize = 16.0,
    @required this.gradient,
    this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ShaderMask(
        shaderCallback: (Rect bounds) {
          if (onPressed == null) {
            final disabledColor = Theme.of(context).disabledColor;
            return LinearGradient(
              colors: [
                disabledColor,
                disabledColor,
              ],
            ).createShader(Offset.zero & bounds.size);
          }

          return gradient.createShader(Offset.zero & bounds.size);
        },
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: fontSize,
            horizontal: fontSize * 2.0,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
