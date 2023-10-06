import 'package:flutter/material.dart';

Widget customColumnIsNotData() {
  return Column(
    children: [
      const Spacer(
        flex: 1,
      ),
      Center(
        child: Image.asset('assets/images/logo.png'),
      ),
      const Spacer(
        flex: 1,
      ),
      Text(
        'ليس لديك اتصال بالانترنت',
      ),
      const Spacer(
        flex: 2,
      ),
    ],
  );
}
