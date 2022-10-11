import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.1,
      height: size.width * 0.1,
      child: const CircularProgressIndicator.adaptive(
        backgroundColor: appWhite,
      ),
    );
  }
}
