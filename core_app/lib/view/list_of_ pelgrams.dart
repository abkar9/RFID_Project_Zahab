import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/components/string_values.dart';
import 'package:rfid_c72_plugin_example/components/widgets/castom_appbar.dart';
import 'package:rfid_c72_plugin_example/model/firebase/data/get_modle.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';
import 'package:rfid_c72_plugin_example/view/info_read_page.dart';

class NameOfPelgrams extends StatelessWidget {
  NameOfPelgrams({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot<Object?>> getQuery = [];
    CustomSizes().init(context);
    return Scaffold(
        appBar: backAppBar(title: "قائمة الحجاج", context: context),
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              color: ColorThemeRFID.lightBlue,
              child: Center(
                  child: Text(
                "${StringValues.almajlisText} ${index + 1}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              width: double.infinity,
              height: CustomSizes.height! / 15,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseMethods.initAndGetData.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<DocumentSnapshot<Object?>> getQuery = [];

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      if (document['almajlis'] == "${this.index + 1}".trim()) {
                        getQuery.add(document);
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      InfoReadPage(doc: document),
                            ));
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: CustomSizes.height! / 15,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: ColorThemeRFID.brown))),
                                child: Center(
                                    child: Text(
                                  document["name"],
                                  style: TextStyle(
                                      fontSize: 20, color: ColorThemeRFID.blue),
                                )),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
              },
            )),
          ],
        ));
  }
}
