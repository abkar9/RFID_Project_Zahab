import 'package:flutter/cupertino.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';

import '../colors_theme.dart';
import '../custom_sizes.dart';

Widget customTextCard({String? title, String? vaule, double? width}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: customText(text: title, textColor: ColorThemeRFID.brown),
          width: CustomSizes.width! / width!,
        ),
        Container(
          height: CustomSizes.height! / 12,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: ColorThemeRFID.brown.withOpacity(0.5),
            borderRadius: BorderRadius.circular(CustomSizes.radiusSize! / 2),
          ),
          child: customText(
              text: vaule, fontSize: 15, textColor: ColorThemeRFID.blue),
        )
      ],
    ),
  );
}
