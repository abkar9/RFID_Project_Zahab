import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/string_values.dart';
import 'package:rfid_c72_plugin_example/view/list_of_%20pelgrams.dart';

SafeArea castomDrawer(
  BuildContext context,
) {
  return SafeArea(
    child: Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      elevation: 0,
      shape: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: ColorThemeRFID.brown,
              width: 3.0,
            ),
          ),
        ),
        child: Column(
          children: [
            /*  header  */
            ListTile(
              trailing: Icon(Icons.menu, color: ColorThemeRFID.brown, size: 30),
              title: Text('المجالس', textAlign: TextAlign.center),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: ColorThemeRFID.brown),
            ),
            Divider(
              color: ColorThemeRFID.brown,
              height: 3,
              thickness: 2,
            ),
            /* End header  */

            buildAlmajlisList(
              index: 40,
            ),
          ],
        ),
      ),
    ),
  );
}

buildAlmajlisList({
  required int index,
}) {
  return Expanded(
    child: ListView.builder(
      itemCount: index,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              color: ColorThemeRFID.lightBrown,
              child: ListTile(
                splashColor: ColorThemeRFID.brown,
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 20, color: ColorThemeRFID.black),
                ),
                title: Text(StringValues.almajlisText,
                    textAlign: TextAlign.center),
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorThemeRFID.black),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        NameOfPelgrams(index: index),
                  ));
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    ),
  );
}
