import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/app_progress_indicator.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/text_button.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

Widget buildPopupDialog(
    BuildContext context, Size size, String title, Widget popupContent) {
  return AlertDialog(
      backgroundColor: appPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: TextStyle(color: appWhite),
        textAlign: TextAlign.center,
      ),
      content: popupContent);
}
