import 'package:flutter/material.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class CustomFormInput extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final IconData? prefix;
  final String hint;
  final bool isObscured;
  final ValueChanged<String?>? onChanged;

  final int minLines;
  final int maxLines;
  final bool enabled;

  const CustomFormInput(
      {Key? key,
      this.label = '',
      required this.controller,
      this.validator,
      this.isObscured = false,
      this.suffix,
      this.prefix,
      this.onChanged,
      required this.hint,
      this.minLines = 1,
      this.maxLines = 1,
      this.enabled = true})
      : super(key: key);

  get appPrimaryColor => null;
  @override
  Widget build(BuildContext context) {
    double _sizeW = MediaQuery.of(context).size.width;
    double _sizeH = MediaQuery.of(context).size.height;
    return Container(
      width: _sizeW,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: TextFormField(
                onChanged: onChanged,
                enabled: enabled,
                minLines: minLines,
                maxLines: maxLines,
                style:
                    TextStyle(color: appPrimaryColor, fontSize: _sizeW * 0.035),
                controller: controller,
                validator: validator,
                obscureText: isObscured,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: appWhite),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  suffixIcon: suffix,
                  filled: true,
                  fillColor: appWhite.withOpacity(0.3),
                  prefixIcon: prefix == null
                      ? null
                      : Icon(
                          prefix,
                          color: appPrimaryColor,
                        ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: _sizeH * 0.1, minWidth: _sizeH * 0.08),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: label == '' ? 0 : 4),
              child: Text(
                label!,
                style: TextStyle(color: appWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
