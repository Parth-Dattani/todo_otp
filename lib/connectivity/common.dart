// import 'package:flutter/cupertino.dart';
// import 'package:flutter_offline/flutter_offline.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class Common{
//
//   static Future<bool> checkInternetConnection() async {
//     var connectivityResult = await OfflineBuilder(connectivityBuilder: (ValueWidgetBuilder<ConnectivityResult>.values));
//     if (connectivityResult ==  ConnectivityResult.none) {
//       await Fluttertoast.showToast(msg: 'No Internet Connection is available.');
//       return false;
//     }
//     return true;
//   }
//
// }