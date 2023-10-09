import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rfid_c72_plugin/rfid_c72_plugin.dart';
import 'package:rfid_c72_plugin/tag_epc.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/widgets/castom_appbar.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_show.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_tags_add.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';
import 'package:rfid_c72_plugin_example/components/widgets/show_bottom_sheet.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';
import 'package:rfid_c72_plugin_example/view/info_read_page.dart';

import '../components/custom_sizes.dart';
import '../components/widgets/custom_card_personal_info.dart';
import 'package:provider/provider.dart';

class InfoAddTag extends StatefulWidget {
  InfoAddTag({
    super.key,
  });

  @override
  State<InfoAddTag> createState() => _InfoAddTagState();
}

class _InfoAddTagState extends State<InfoAddTag> {
  _InfoAddTagState();

  String platformVersion = 'Unknown';
  bool isConnected = false;
  bool isLoading = true;
  int totalEPC = 0, invalidEPC = 0, scannedEPC = 0;
  FirebaseMethods firebaseFirestore = FirebaseMethods();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    FirebaseMethods().initAndGetData;
    FirebaseMethods().initTags.get().then((QuerySnapshot querySnapshot) {
      tags = querySnapshot.docs;
    });
    FirebaseMethods.initAndGetDataTag;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = (await RfidC72Plugin.platformVersion)!;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    RfidC72Plugin.connectedStatusStream
        .receiveBroadcastStream()
        .listen(updateIsConnected);
    RfidC72Plugin.tagsStatusStream.receiveBroadcastStream().listen(updateTags);
    await RfidC72Plugin.connect;
    await RfidC72Plugin.setWorkArea('-40');
    await RfidC72Plugin.setPowerLevel('8');
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
      isLoading = false;
    });
  }

  var tags = [];

  bool isTagAlreadyUsed = false;

  List<TagEpc> _data = [];

  final List<String> _EPC = [];

  void updateTags(dynamic result) async {
    setState(() {
      _data = TagEpc.parseTags(result);
      totalEPC = _data.toSet().toList().length;
      print(_data);
    });
  }

  void updateIsConnected(dynamic isConnected) {
    //setState(() {
    isConnected = isConnected;
    //});
  }

  String tagCode = '';

  @override
  Widget build(BuildContext context) {
    var usersData = Provider.of<ProviderModel>(context, listen: false);
    CustomSizes().init;
    String code = "الكود بعد المسح";
    var numberOfTag = Provider.of<ProviderModel>(context).change;
    var doc = Provider.of<ProviderModel>(context).element;

    String t1 = "${doc["tag1"]}";
    String t2 = "${doc["tag2"]}";
    String t3 = "${doc["tag3"]}";

    return Scaffold(
      appBar: backAppBar(title: "إضافة تاق", context: context),
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
              customTagsAdd(context, tag1: t1, tag2: t2, tag3: t3),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: CustomSizes.width,
                  alignment: Alignment.center,
                  child: customText(
                      fontSize: 16,
                      text: "اختار مكان اضافة التاق",
                      textAlign: TextAlign.center,
                      textColor: ColorThemeRFID.blue)),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: CustomSizes.height! / 10,
                child: Center(
                    child: customText(
                        fontSize: 16,
                        text: usersData.code.toString(),
                        textAlign: TextAlign.center,
                        textColor: ColorThemeRFID.blue)),
                decoration: BoxDecoration(
                    color: ColorThemeRFID.brown.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: ColorThemeRFID.brown,
            onPressed: () async {
              await RfidC72Plugin.startSingle.then((value) {
                if (_data.isNotEmpty) {
                  setState(() {
                    tagCode = _data.first.epc;
                    _EPC.add(_data.first.epc);
                  });
                  Provider.of<ProviderModel>(context, listen: false)
                      .increment(_data.first.epc);
                  _data.clear();
                  for (var element in tags) {
                    print(element['tag'] + ';lkjhgfdfghjkl');
                    if (element['tag'].toString() == tagCode.toString()) {
                      setState(() {
                        isTagAlreadyUsed = true;
                      });
                      break;
                    } else {
                      setState(() {
                        isTagAlreadyUsed = false;
                      });
                    }
                  }
                } else {
                  showBottom(context, text: "فشل المسح ");
                }
              });
            },
          ),
          FloatingActionButton(
            backgroundColor: ColorThemeRFID.brown,
            onPressed: () async {
              if (tagCode.isNotEmpty && _EPC.first.isNotEmpty) {
                customShowDialog(
                    context: context,
                    textTitle: "إضافة تاق",
                    textContent: "هل انت متأكد من اضافة التاق",
                    textButton: "موافق",
                    onPressed: () {
                      if (tags.isNotEmpty && isTagAlreadyUsed) {
                        firebaseFirestore.addData(
                            tag: tagCode.toString(),
                            doc: "${doc["idNumber"]}".toString(),
                            numberOfTag: "${numberOfTag.toString()}");

                        firebaseFirestore.addUserTag(
                            docTag: tagCode.toString());

                        Provider.of<ProviderModel>(context, listen: false)
                            .increment(code);
                        Provider.of<ProviderModel>(context, listen: false)
                            .changeTagValue(
                                chick: numberOfTag.toString(),
                                tag: tagCode.toString());
                        _EPC.clear();
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      InfoReadPage(doc: doc),
                            ),
                            (route) => true);
                      } else {
                        Navigator.pop(context);
                        showBottom(context, text: "التاق مستخدام ");
                      }
                    });
              } else {
                showBottom(context, text: "يجب مسح التاق ");
              }
              context.findRootAncestorStateOfType();
            },
            child: Icon(Icons.publish_outlined),
          ),
        ],
      ),
    );
  }
}
