import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';

showBottom(BuildContext context, {String text = "لم يتم معرفة التاق "}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorThemeRFID.brown,
      content: Center(child: Text(text)),
      duration: Duration(seconds: 2),
    ),
  );
}
