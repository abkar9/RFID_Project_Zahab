import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/view/home.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    animation = Tween<double>(begin: .3, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
    goToNextView();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomSizes().init(context);

    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/logo_image.png'),
        FadeTransition(
          opacity: animation!,
          child: Text(
            ' زهـــاب ',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorThemeRFID.blue,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
          ),
          (route) => false);
    });
  }
}
