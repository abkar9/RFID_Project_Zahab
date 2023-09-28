import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';

import '../colors_theme.dart';
import '../string_values.dart';
import 'custom_text.dart';
import 'custom_text_card.dart';

Widget customCardAnotherPersonalInfo(BuildContext context,
    {String? numbermajles,
    String? menaCamp,
    String? almajlisMona,
    String? menamanamn,
    String? almajlisarafa,
    String? arafatmanamn,
    String? arafatCamp,
    String? location}) {
  CustomSizes().init(context);

  return Container(
      width: CustomSizes.width!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: customTextCard(
                      vaule: numbermajles, title: 'رقم المجلس', width: 1))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: customTextCard(
                      title: "مخيم منى ", vaule: menaCamp, width: 3)),
              Expanded(
                  child: customTextCard(
                      title: "المجلس", vaule: almajlisMona, width: 3)),
              Expanded(
                  child: customTextCard(
                      title: "منام منى ", vaule: menamanamn, width: 3))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: customTextCard(
                      vaule: arafatCamp, title: "مخيم عرفة ", width: 3)),
              Expanded(
                  child: customTextCard(
                      title: "المجلس", vaule: almajlisarafa, width: 3)),
              Expanded(
                  child: customTextCard(
                      title: "منام عرفة ", vaule: arafatmanamn, width: 3))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: customTextCard(
                      title: "عنوان السكن", vaule: location, width: 1))
            ],
          ),
        ],
      ));
}
