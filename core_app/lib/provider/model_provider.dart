import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';

class ProviderModel with ChangeNotifier {
  String code = 'الكود بعد المسح';
  String change = "1";
  String tag1 = 'متاح';
  String tag2 = "متاح";
  String tag3 = "متاح";

  QuerySnapshot<Map<String, dynamic>>? usersOfData;

  var userData;
  var element;

  void increment(String c) {
    code = c;
    notifyListeners();
  }

  void getDataUsers() async {
    QuerySnapshot<Map<String, dynamic>> users =
        await FirebaseMethods().initAndGetData.get();
    usersOfData = users;
    notifyListeners();
  }

  void changeValue({required String chick, required String tag}) {
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
