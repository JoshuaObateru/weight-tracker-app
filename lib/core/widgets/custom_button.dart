import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class CustomBtn extends StatelessWidget {
  final String label;
  final bool isLoading;
  final Function() onPress;
  final Widget? icon;

  const CustomBtn(
      {Key? key,
      required this.label,
      this.isLoading = false,
      required this.onPress,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: RawMaterialButton(
        onPressed: onPress,
        child: isLoading == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: size.width * 0.04,
                      height: size.width * 0.04,
                      child: CircularProgressIndicator(
                        color: appPrimaryColor,
                      ),
                    ),
                  ),
                  Text(
                    'Please wait...',
                    style: TextStyle(
                        color: appPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null ? icon! : Container(),
                  Text(
                    label,
                    style: TextStyle(
                        color: appPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
        fillColor: appWhite,
        elevation: 0,
        constraints: BoxConstraints(
          minWidth: double.maxFinite,
          minHeight: 45,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
