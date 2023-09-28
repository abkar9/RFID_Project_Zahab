import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rfid_c72_plugin/rfid_c72_plugin.dart';
import 'package:rfid_c72_plugin/tag_epc.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/view/info_read_page.dart';
import 'package:provider/provider.dart';

import '../../provider/model_provider.dart';

import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
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
  @override
  Widget build(BuildContext context) {
    var usersData =
        Provider.of<ProviderModel>(context, listen: false).usersOfData;
    return Scaffold(
      //////////////////////////////////////////////////////////
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor:
                  _isContinuousCall ? Colors.red : ColorThemeRFID.brown,
              child: _isContinuousCall ? Icon(Icons.stop) : Icon(Icons.loop),
              onPressed: () async {
                bool? isStarted = _isContinuousCall == true
                    ? await RfidC72Plugin.stop
                    : await RfidC72Plugin.startContinuous;
                setState(() {
                  _isContinuousCall = !_isContinuousCall;
                });
              }),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.cleaning_services),
              onPressed: () async {
                await RfidC72Plugin.clearData;
                setState(() {
                  _data.clear();
                  //     _logs.clear();
                });
              }),
        ],
      ),
      body: _data.isEmpty
          ? Container(
              child: Center(
                  child: Lottie.asset(
              'assets/lottie/EFXISswRKM.json',
            )))
          : Column(
              children: [
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: ColorThemeRFID.brown,
                  child: Center(
                    child: Text(
                      ' عدد التاقات المقروءة: $_totalEPC',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._data.map((TagEpc tag) {
                          _EPC.add(tag.epc.replaceAll(RegExp('EPC:'), ''));

                          return getUserbyTag(tag);
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget getUserbyTag(TagEpc tag) {
    var conTag = tag.epc.replaceAll(RegExp("EPC:"), '');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: CustomSizes.height! / 12,
            child: Expanded(
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
                      if (document['tag1'] == "$conTag" ||
                          document['tag2'] == "$conTag" ||
                          document['tag3'] == "$conTag") {
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
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: ColorThemeRFID.brown))),
                                child: Column(
                                  children: [
                                    Center(
                                        child: Text(
                                      " ${document["name"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorThemeRFID.blue),
                                    )),
                                    Center(
                                        child: Text(
                                      "  المجلس رقم${document["almajlis"]}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorThemeRFID.black),
                                    )),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }
}
