//  // Platform messages are asynchronous, so we initialize in an async method.
//   import 'package:flutter/services.dart';
// import 'package:rfid_c72_plugin/rfid_c72_plugin.dart';

// Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = (await RfidC72Plugin.platformVersion)!;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//     RfidC72Plugin.connectedStatusStream
//         .receiveBroadcastStream()
//         .listen(updateIsConnected);
//     RfidC72Plugin.tagsStatusStream.receiveBroadcastStream().listen(updateTags);
//     await RfidC72Plugin.connect;
//     await RfidC72Plugin.setWorkArea('-40');
//     await RfidC72Plugin.setPowerLevel('8');
//     if (!mounted) return;

//     setState(() {
//       platformVersion = platformVersion;
//       isLoading = false;
//     });
//   }