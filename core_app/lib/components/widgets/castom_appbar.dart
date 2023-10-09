import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/view/addData/add_flis_firebase.dart';
import 'package:rfid_c72_plugin_example/view/home.dart';
import 'package:rfid_c72_plugin_example/view/info_read_page.dart';
import 'package:rfid_c72_plugin_example/view/navPage/read_page.dart';

AppBar appBar(
    {required String title,
    required Icon icon,
    required BuildContext context,
    var onPressed}) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onLongPress: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                bulkUpload(),
          ));
        },
        child: Image.asset(
          'assets/images/logo_image.png',
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(title,
        style: const TextStyle(color: Color.fromRGBO(11, 121, 172, 100))),
    shape: const RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Color.fromRGBO(161, 138, 84, 100)),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        )),
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
  );
}

AppBar backAppBar({
  required String title,
  required BuildContext context,
}) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Image.asset(
        'assets/images/logo_image.png',
        fit: BoxFit.cover,
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_forward,
            size: 30,
          ))
    ],
    title: Text(title,
        style: TextStyle(color: const Color.fromRGBO(11, 121, 172, 100))),
    shape: const RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Color.fromRGBO(161, 138, 84, 100)),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        )),
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
  );
}
