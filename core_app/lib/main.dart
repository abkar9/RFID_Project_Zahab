import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/firebase_options.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';
import 'package:rfid_c72_plugin_example/view/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => ProviderModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderModel>(context, listen: false).getDataUsers();
    CustomSizes().init;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      theme: ColorThemeRFID.themeLight(context),
    );
  }
}
