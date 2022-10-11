import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color? color;
  final FontWeight? fontWeight;
  const CustomTextButton(
      {Key? key,
      required this.size,
      required this.label,
      required this.onPressed,
      this.color,
      this.fontWeight})
      : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Text(
          label,
          style: TextStyle(
              color: color ?? appWhite,
              fontWeight: fontWeight ?? FontWeight.w900,
              fontSize: size.width * 0.04),
          textAlign: TextAlign.center,
        ));
  }
}
