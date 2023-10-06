import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/netWork.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_column_is_not_data.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_textfield.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';
import 'package:provider/provider.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          ////////////////// chick if  network is working //////////
          if (snapshot.data == ConnectivityResult.none ||
              snapshot.data == null && rusles == ConnectivityResult.none) {
            return customColumnIsNotData();
          } else {
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseMethods().initAndGetData.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    try {
                      Provider.of<ProviderModel>(context, listen: false)
                          .changevalueFromStrams(user: snapshot.data!.docs);
                    } catch (e) {
                      print(e);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: customTextField(context,
                                title: " رقم الهوية ",
                                textAlign: TextAlign.center,
                                data: snapshot.data,
                                size: 20,
                                color: ColorThemeRFID.blue)),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          }
        });
  }
}
