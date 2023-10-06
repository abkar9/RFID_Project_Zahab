import 'package:connectivity_plus/connectivity_plus.dart';

var rusles;

chickInternet() async {
  rusles = await Connectivity().checkConnectivity();
}
