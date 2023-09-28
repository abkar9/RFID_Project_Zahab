import 'package:flutter/material.dart';

Widget customText({
  String? text,
  double? fontSize,
  Color? textColor,
  TextAlign? textAlign,
}) {
  return Text(
    text!,
    style: TextStyle(
      fontSize: fontSize,
      color: textColor,
    ),
    textAlign: textAlign,
  );
}

Widget customText2({
  String? text,
  double? fontSize,
  Color? textColor,
  TextAlign? textAlign,
}) {
  return Text(
    text!,
    style: TextStyle(
      fontSize: fontSize,
      color: textColor,
      overflow: TextOverflow.ellipsis,
    ),
    textAlign: textAlign,
  );
}
