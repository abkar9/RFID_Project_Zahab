
import 'package:flutter/cupertino.dart';
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
  InfoAddTag({super.key, this.doc});

  var doc;

  @override
  State<InfoAddTag> createState() => _InfoAddTagState(doc);
}

class _InfoAddTagState extends State<InfoAddTag> {
  var doc;
  _InfoAddTagState(this.doc);
  final bool _isHaveSavedData = false;
  final bool _isStarted = false;
  final bool _isEmptyTags = false;
  String _platformVersion = 'Unknown';
  bool _isConnected = false;
  bool _isLoading = true;
  int _totalEPC = 0, _invalidEPC = 0, _scannedEPC = 0;
  FirebaseMethods firebaseFirestore = FirebaseMethods();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    FirebaseMethods.initAndGetData;
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
      _platformVersion = platformVersion;
      _isLoading = false;
    });
  }

  List<TagEpc> _data = [];

  final List<String> _EPC = [];

  void updateTags(dynamic result) async {
    setState(() {
      _data = TagEpc.parseTags(result);
      _totalEPC = _data.toSet().toList().length;
      print(_data);
    });
  }

  void updateIsConnected(dynamic isConnected) {
    //setState(() {
    _isConnected = isConnected;
    //});
  }

  bool _isContinuousCall = false;
  String tagCode = '';

  @override
  Widget build(BuildContext context) {
    var usersData = Provider.of<ProviderModel>(context, listen: false);
    FirebaseMethods.initAndGetData;
    CustomSizes().init;
    String code = "الكود بعد المسح";
    var pro = Provider.of<ProviderModel>(context).change;
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
              customTagsAdd(context,
                  tag1: t1, tag2: "${doc["tag2"]}", tag3: "${doc["tag3"]}"),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: ColorThemeRFID.brown,
            onPressed: () async {
              await RfidC72Plugin.startSingle;
              if (_data.isNotEmpty) {
                setState(() {
                  tagCode = _data.first.epc;
                  _EPC.add(_data.first.epc);
                });
                Provider.of<ProviderModel>(context, listen: false)
                    .increment(_data.first.epc);
                _data.clear();
                setState(() {});
              } else {
                showBottom(context, text: "فشل المسح ");
              }
            },
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            backgroundColor: ColorThemeRFID.brown,
            onPressed: () async {
              print("kkkkkkkkkkkkkkkkk${tagCode}");

              if (tagCode.isNotEmpty && _EPC.first.isNotEmpty) {
                customShowDialog(
                    context: context,
                    textTitle: "إضافة تاق",
                    textContent: "هل انت متأكد من اضافة التاق",
                    textButton: "موافق",
                    onPressed: () {
                      firebaseFirestore.addData(
                          tag: tagCode.toString(),
                          doc: "${doc["idNumber"]}".toString(),
                          numberOfTag: "${pro.toString()}");
                      Provider.of<ProviderModel>(context, listen: false)
                          .increment('الكود بعد المسح');
                      Provider.of<ProviderModel>(context, listen: false)
                          .changeValue(
                              chick: pro.toString(), tag: tagCode.toString());
                      _EPC.clear();
                      Navigator.pop(context);
                      Navigator.of(context).pushAndRemoveUntil(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    InfoReadPage(doc: doc),
                          ),
                          (route) => true);
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
