//custom design widget for card personal information in info pages
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/string_values.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';

import '../custom_sizes.dart';

// custom card for personal information for ino pages
Widget customCardPersonalInfo(BuildContext context,
    {String? name,
    String? nationality,
    String? idNumber,
    String? phoneNumber,
    String? bookingNumber}) {
  CustomSizes().init(context);

  return Container(
    height: CustomSizes.height! / 2.5,
    width: CustomSizes.width!,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomSizes.radiusSize!),
            border: Border.all(
              color: ColorThemeRFID.brown,
              width: 1.0,
            ),
          ),
          margin: EdgeInsets.only(top: CustomSizes.height! / 12),
          child: SizedBox(
            height: CustomSizes.height! / 4,
            width: CustomSizes.width!,
            child: Padding(
              padding: EdgeInsets.only(top: CustomSizes.paddingSize! * 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                      text: name,
                      fontSize: CustomSizes.textSize,
                      textColor: ColorThemeRFID.brown),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customText(
                              text: StringValues.nationality,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.black),
                          customText(
                              text: nationality,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.blue),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customText(
                              text: StringValues.idNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.black),
                          customText(
                              text: idNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.blue),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customText(
                              text: StringValues.phoneNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.black),
                          customText(
                              text: phoneNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.blue),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          customText(
                              text: StringValues.bookingNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.black),
                          customText(
                              text: bookingNumber,
                              fontSize: CustomSizes.textSize,
                              textColor: ColorThemeRFID.blue),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: .0,
          left: .0,
          right: .0,
          child: Container(
            height: CustomSizes.height! / 7,
            child: CircleAvatar(
              radius: CustomSizes.radiusSize,
              backgroundColor: ColorThemeRFID.brown,
              child: Icon(
                Icons.person,
                size: CustomSizes.sizeIcon! * 1.5,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
