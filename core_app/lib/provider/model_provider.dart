import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';

class ProviderModel with ChangeNotifier {
  String code = 'الكود بعد المسح';
  String change = "1";
  String? tag1;
  String? tag2;
  String? tag3;

  bool isRead = false;

  QuerySnapshot<Map<String, dynamic>>? usersOfData;

  var userData;
  var element;

  void changeTagProvider({required String value, required int numberOfTag}) {}

  void increment(String c) {
    code = c;
    notifyListeners();
  }

  void changeVauleIsRead(bool chick) {
    isRead = chick;
    notifyListeners();
  }

  void getDataUsers() async {
    QuerySnapshot<Map<String, dynamic>> users =
        await FirebaseMethods().initAndGetData.get();
    usersOfData = users;
    notifyListeners();
  }

  void changeTagValue({required String chick, required String tag}) {
    change = chick;
    if (chick == "1") {
      tag1 = tag;
    } else if (chick == "2") {
      tag2 = tag;
    } else if (chick == "3") {
      tag3 = tag;
    }
    notifyListeners();
  }

  void changevalueFromStrams({var user}) {
    userData = user;
  }

  void changevalueFromElement({var element}) {
    this.element = element;
  }
}
