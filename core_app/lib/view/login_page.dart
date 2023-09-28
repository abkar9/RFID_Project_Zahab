import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/widgets/castom_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        title: "title",
        icon: Icon(Icons.arrow_forward),
      ),
    );
  }
}
