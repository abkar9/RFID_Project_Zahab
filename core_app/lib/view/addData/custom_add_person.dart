import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';

class AddPersonData extends StatelessWidget {
  const AddPersonData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: customText(
                  text: "title",
                  textColor: const Color.fromARGB(255, 59, 58, 55)),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: customText(
                  text: "vaule", fontSize: 15, textColor: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
