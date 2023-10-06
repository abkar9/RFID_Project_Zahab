import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rfid_c72_plugin/rfid_c72_plugin.dart';
import 'package:rfid_c72_plugin/tag_epc.dart';
import 'package:lottie/lottie.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/components/netWork.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_column_is_not_data.dart';
import 'package:rfid_c72_plugin_example/components/widgets/show_bottom_sheet.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';
import 'package:rfid_c72_plugin_example/view/info_read_page.dart';
import 'package:provider/provider.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({Key? key}) : super(key: key);

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  MethodChannel channel = MethodChannel('rfid');

  String platformVersion = 'Unknown';
  bool isConnected = false;
  bool isLoading = true;
  int totalEPC = 0, invalidEPC = 0, scannedEPC = 0;
  FirebaseMethods firebaseFirestore = FirebaseMethods();

  @override
  void initState() {
    super.initState();
    rusles == null ? chickInternet() : null;
    initPlatformState();
    FirebaseMethods().initAndGetData;
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

  List<TagEpc> _data = [];

  void updateTags(dynamic result) async {
    setState(() {
      _data = TagEpc.parseTags(result);
      totalEPC = _data.toSet().toList().length;
      print(_data);
    });
  }

  void updateIsConnected(dynamic isConnected) {
    isConnected = isConnected;
  }

  @override
  Widget build(BuildContext context) {
    var usersData =
        Provider.of<ProviderModel>(context, listen: false).usersOfData;
    channel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'dispatchKeyEvent') {
        // Retrieve the data sent from the native side
        String data = call.arguments['key'];

        // Process the data as needed
        print('Received data: $data');
      }
    });

    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          ////////////////// chick if  network is working //////////
          if (snapshot.data == ConnectivityResult.none ||
              snapshot.data == null && rusles == ConnectivityResult.none) {
            return Scaffold(
              body: customColumnIsNotData(),
            );
          } else {
            return Scaffold(
              //////////////////////////////////////////////////////////
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                      backgroundColor: ColorThemeRFID.brown,
                      child: Icon(Icons.add),
                      onPressed: () async {
                        await RfidC72Plugin.startSingle.then((value) {
                          if (_data.isNotEmpty) {
                            String tagData = _data.first.epc;
                            print(tagData);
                            if (usersData!.docs.isNotEmpty) {
                              usersData.docs.forEach((element) {
                                if (element["tag1"] == tagData) {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        InfoReadPage(
                                      doc: element,
                                    ),
                                  ));
                                } else if (element["tag2"] == tagData) {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        InfoReadPage(
                                      doc: element,
                                    ),
                                  ));
                                } else if (element["tag3"] == tagData) {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        InfoReadPage(
                                      doc: element,
                                    ),
                                  ));
                                }
                              });
                            }
                            _data.clear();
                          } else {
                            showBottom(context);
                          }
                        });
                      }),
                ],
              ),

              body: Container(
                  child: Center(
                      child: SizedBox(
                height: CustomSizes.height! / 2,
                child: Lottie.asset(
                  'assets/lottie/ppixZ5u3t6.json',
                ),
              ))),
            );
          }
        });
  }
}
