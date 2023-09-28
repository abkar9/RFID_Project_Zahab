import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_textfield.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: customTextField(context,
                title: " رقم الهوية ",
                textAlign: TextAlign.center,
                size: 20,
                color: ColorThemeRFID.blue)),
      ],
    );
  }
}
