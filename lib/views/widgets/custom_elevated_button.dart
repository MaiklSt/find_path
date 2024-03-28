import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.backgroundColor = const Color(0xFF40C4FF),
    this.borderColor = const Color(0xFF4398FF),
    this.borderRadius = 12.5,
    this.titleColor = Colors.white,
    required this.buttonTitle
  });

  final Function()? onPressed;
  final String buttonTitle;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return backgroundColor;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonTitle, style: TextStyle(color: titleColor)),
    );
  }
}
