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
  String? tagData;
  int totalEPC = 0, invalidEPC = 0, scannedEPC = 0;
  FirebaseMethods firebaseFirestore = FirebaseMethods();
  static const platform = const MethodChannel('naser.com');
  bool buttonEvent = false;
  List<TagEpc> _data = [];
  List<TagEpc> em = [];
  // var userData;
  String tagCode = '';

  @override
  void initState() {
    super.initState();
    _data.clear();
    rusles = chickInternet();
    initPlatformState();
    FirebaseMethods().initAndGetData;
    _setupButtonListener();
  }

  //call native press code
  Future<void> _setupButtonListener() async {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'buttonEvent') {
        RfidC72Plugin.startSingle.then((value) {
          if (_data.isNotEmpty) {
            setState(() {
              tagData = _data.first.epc;
              buttonEvent = true;
              _data.clear();
            });
          } else {
            showBottom(context);
          }
        });
      }
    });
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

  void updateTags(dynamic result) async {
    setState(() {
      _data = TagEpc.parseTags(result);
      totalEPC = _data.toSet().toList().length;
    });
  }

  void updateIsConnected(dynamic isConnected) {
    setState(() {
      isConnected = isConnected;
    });
  }

  @override
  Widget build(BuildContext cont) {
    print(_data.length);
    var usersData = Provider.of<ProviderModel>(
      cont,
    ).usersOfData;

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
                ////////////////////////////////////////////////////
                floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorThemeRFID.brown,
                    child: Icon(Icons.add),
                    onPressed: () async {
                      RfidC72Plugin.startSingle.then((value) {
                        if (value!) {
                          print(value);
                          RfidC72Plugin.tagsStatusStream
                              .receiveBroadcastStream()
                              .listen(updateTags);
                          setState(() {
                            tagCode = _data.first.epc;
                          });
                          Provider.of<ProviderModel>(context, listen: false)
                              .increment(_data.first.epc);
                          _data.clear();
                          print(_data.first.epc);

                          _data.forEach((element) {
                            print(element.epc);
                          });
                        } else {
                          showBottom(context, text: "فشل المسح ");
                        }
                      });
                    }),
                body:
                    customShowUserAfterRead(userData: usersData, context: cont)
                // : Container(
                //     child: Center(
                //       child: SizedBox(
                //         height: CustomSizes.height! / 2,
                //         child: Lottie.asset(
                //           'assets/lottie/ppixZ5u3t6.json',
                //         ),
                //       ),
                //     ),
                //   ),
                );
          }
        });
  }

  Widget customShowUserAfterRead(
      {required var userData, required BuildContext context}) {
    // if (buttonEvent) {
    //   try {
    //     if (userData!.docs.isNotEmpty) {
    //       for (var element in userData.docs) {
    //         if (element["tag1"] == tagData) {
    //           print(tagData);
    //           userData = element;
    //           Provider.of<ProviderModel>(context, listen: false)
    //               .changeVauleIsRead(true);
    //           tagData = '';
    //           break;
    //         } else if (element["tag2"] == tagData) {
    //           print(tagData);
    //           userData = element;
    //           Provider.of<ProviderModel>(context, listen: false)
    //               .changeVauleIsRead(true);
    //           tagData = '';
    //           break;
    //         } else if (element["tag3"] == tagData) {
    //           print(tagData);
    //           userData = element;
    //           Provider.of<ProviderModel>(context, listen: false)
    //               .changeVauleIsRead(true);
    //           tagData = '';
    //           break;
    //         }
    //       }
    //     }
    //   } catch (e) {}
    //   setState(() {
    //     buttonEvent = false;
    //   });
    // }

    return Center(
        child: ElevatedButton.icon(
            onPressed: () {
              setState(() {});
              buttonEvent = false;
              _data.clear();
              Provider.of<ProviderModel>(context, listen: false).increment('');
            },
            icon: Icon(Icons.grass_outlined),
            label: Text(Provider.of<ProviderModel>(
              context,
            ).code.toString())));
  }
}
