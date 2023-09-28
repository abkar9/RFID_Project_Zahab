import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/view/splash/splash_scren_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
