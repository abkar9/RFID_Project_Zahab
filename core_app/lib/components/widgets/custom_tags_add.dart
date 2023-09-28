//custom design widget for card personal information in info pages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';

import '../custom_sizes.dart';

// custom card for personal information for ino pages
Widget customTagsAdd(
  BuildContext context, {
  String? tag1 = '',
  String? tag2 = '',
  String? tag3 = '',
}) {
  CustomSizes().init(context);

  return Container(
    height: CustomSizes.height! / 10,
    width: CustomSizes.width!,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomSizes.radiusSize!),
        border: Border.all(
          color: ColorThemeRFID.brown,
          width: 1.0,
        ),
      ),
      child: SizedBox(
        height: CustomSizes.height! / 2,
        width: CustomSizes.width!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<ProviderModel>(context, listen: false)
                        .changeValue(chick: '1', tag: '');
                  },
                  child: Container(
                    color: Provider.of<ProviderModel>(context, listen: true)
                                .change ==
                            "1"
                        ? ColorThemeRFID.lightBrown
                        : ColorThemeRFID.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                            text: "التاق رقم 1",
                            fontSize: CustomSizes.textSize,
                            textColor: ColorThemeRFID.black),
                        customText2(
                            text: tag1!.isEmpty
                                ? "متاح"
                                : tag1.hashCode.toString(),
                            fontSize: CustomSizes.textSize,
                            textColor: Provider.of<ProviderModel>(context,
                                            listen: true)
                                        .change ==
                                    "1"
                                ? ColorThemeRFID.blue
                                : ColorThemeRFID.brown),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<ProviderModel>(context, listen: false)
                        .changeValue(chick: '2', tag: '');
                  },
                  child: Container(
                    color: Provider.of<ProviderModel>(context, listen: true)
                                .change ==
                            "2"
                        ? ColorThemeRFID.lightBrown
                        : ColorThemeRFID.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                            text: "التاق رقم 2",
                            fontSize: CustomSizes.textSize,
                            textColor: ColorThemeRFID.black),
                        customText2(
                            text: tag2!.isEmpty
                                ? "متاح"
                                : tag2.hashCode.toString(),
                            fontSize: CustomSizes.textSize,
                            textColor: Provider.of<ProviderModel>(context,
                                            listen: true)
                                        .change ==
                                    "2"
                                ? ColorThemeRFID.blue
                                : ColorThemeRFID.brown),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<ProviderModel>(context, listen: false)
                        .changeValue(chick: '3', tag: '');
                  },
                  child: Container(
                    color: Provider.of<ProviderModel>(context, listen: true)
                                .change ==
                            "3"
                        ? ColorThemeRFID.lightBrown
                        : ColorThemeRFID.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customText(
                            text: "التاق رقم 3",
                            fontSize: CustomSizes.textSize,
                            textColor: ColorThemeRFID.black),
                        customText2(
                            text: tag3!.isEmpty
                                ? "متاح"
                                : tag3.hashCode.toString(),
                            fontSize: CustomSizes.textSize,
                            textColor: Provider.of<ProviderModel>(context,
                                            listen: true)
                                        .change ==
                                    "3"
                                ? ColorThemeRFID.blue
                                : ColorThemeRFID.brown),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
