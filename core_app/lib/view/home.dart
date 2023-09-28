import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rfid_c72_plugin/rfid_c72_plugin.dart';
import 'package:rfid_c72_plugin/tag_epc.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/rfid_scanner.dart';
import 'package:rfid_c72_plugin_example/view/navPage/addPage.dart';
import 'package:rfid_c72_plugin_example/view/navPage/readPage.dart';
import 'package:rfid_c72_plugin_example/view/navPage/scanPage.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../components/widgets/castom_appbar.dart';
import '../components/widgets/custom_drawer.dart';
import '../model/firebase/flirebase_get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var chanel = MethodChannel("my_chanel");

  // final callCollection = FirebaseMethods.initAndGetData;
  callInput() {
    chanel.invokeMethod("callInput");
  }

  @override
  List<Widget> page = const [RfidScanner(), ScanPage(), AddPage()];
  int currentIndex = 0;
  bool chick = false;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<IconData> icon = [
    Icons.rss_feed_outlined,
    Icons.qr_code_scanner,
    Icons.tag,
  ];

  List<String> titlePage = ["قراءة التاق", "مسح تصنيفي", "إضافة تاق"];

  Widget build(BuildContext context) {
    // final connut = Provider.of<ProviderModel>(context);
    return Scaffold(
      endDrawer: castomDrawer(context),
      appBar: appBar(
          context: context,
          title: titlePage[currentIndex],
          icon:
              Icon(Icons.arrow_forward, size: 30, color: ColorThemeRFID.brown),
          onPressed: () {}),
      body: page[currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
          rightCornerRadius: 20,
          leftCornerRadius: 20,
          elevation: 50,
          iconSize: 30,
          borderWidth: 5,
          borderColor: ColorThemeRFID.brown,
          gapLocation: GapLocation.none,
          blurEffect: true,
          activeColor: ColorThemeRFID.brown,
          icons: icon,
          activeIndex: currentIndex,
          onTap: onTap),
    );
  }
}
