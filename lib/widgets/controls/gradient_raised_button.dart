import 'package:flutter/material.dart';

class GradientRaisedButton extends StatelessWidget {
  final double borderRadius;
  final double fontSize;
  final Gradient gradient;
  final Function onPressed;
  final String text;

  const GradientRaisedButton({
    Key key,
    this.borderRadius = 0.0,
    this.fontSize = 16.0,
    @required this.gradient,
    this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: onPressed,
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: onPressed == null ? null : gradient,
          ),
          padding: EdgeInsets.symmetric(
            vertical: fontSize,
            horizontal: fontSize * 2.0,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: onPressed == null
                  ? Theme.of(context).disabledColor
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      );
}
