import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/components/string_values.dart';
import 'package:rfid_c72_plugin_example/components/widgets/castom_appbar.dart';

import '../components/widgets/custom_another_personal_info.dart';
import '../components/widgets/custom_card_personal_info.dart';

class InfoReadPage extends StatelessWidget {
  InfoReadPage({super.key, this.doc});

  dynamic doc;

  @override
  Widget build(BuildContext context) {
    //init custom size class
    CustomSizes().init(context);
    return Scaffold(
      appBar: backAppBar(
        context: context,
        title: StringValues.tagInfoTitle,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: CustomSizes.width,
          height: CustomSizes.height! / 1,
          padding: EdgeInsets.all(CustomSizes.paddingSize!),
          child: ListView(
            children: [
              customCardPersonalInfo(context,
                  name: "${doc["name"]}",
                  nationality: "${doc["nationality"]}",
                  idNumber: "${doc["idNumber"]}",
                  phoneNumber: "${doc["phoneNumber"]}",
                  bookingNumber: "${doc["bookingNumber"]}"),
              customCardAnotherPersonalInfo(
                context,
                numbermajles: "${doc["almajlis"]}",
                menaCamp: "${doc["monaCamp"]}",
                almajlisMona: "${doc["almajlisMona"]}",
                menamanamn: "${doc["mnamMona"]}",
                location: "${doc["address"]}",
                almajlisarafa: "${doc["almajlisarafa"]}",
                arafatCamp: "${doc["arafaCamp"]}",
                arafatmanamn: "${doc["mnamarafaa"]}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
