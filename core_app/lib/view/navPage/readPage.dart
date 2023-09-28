import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    CustomSizes().init(context);
    return Container(
        child: Center(
            child: SizedBox(
      height: CustomSizes.height! / 2,
      child: Lottie.asset(
        'assets/lottie/ppixZ5u3t6.json',
      ),
    )));
  }
}
