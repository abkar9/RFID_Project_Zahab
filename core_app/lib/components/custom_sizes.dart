import 'package:flutter/material.dart';

class CustomSizes {
  static double? width;
  static double? height;
  static double? textSize;
  static double? titleSize;
  static double? sizeIcon;
  static double? paddingSize;
  static double? radiusSize;

  void init(BuildContext context,
      {double reTextSize = 70,
      double reTitleSize = 1,
      double reSizeIcon = 20,
      double rePaddingSize = 15,
      double reRadiusSize = 20}) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    textSize = (height! + width!) / reTextSize;
    titleSize = CustomSizes.textSize! * reTitleSize;
    sizeIcon = (height! + width!) / reSizeIcon;
    paddingSize = rePaddingSize;
    radiusSize = reRadiusSize;
  }
}
