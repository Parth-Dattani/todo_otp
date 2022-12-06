// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class CurrentLocationFind extends StatefulWidget {
//   const CurrentLocationFind({Key? key}) : super(key: key);
//
//   @override
//   State<CurrentLocationFind> createState() => _CurrentLocationFindState();
// }
//
// class _CurrentLocationFindState extends State<CurrentLocationFind> {
//
//   final Geolocator locator = Geolocator();
//
//   late Position currentPosition;
//   String currentLocation = '';
//   late LocationPermission permission;
//   bool serviceEnable = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Current Location Find", style: TextStyle(fontSize: 14,),),
//       ),
//       body: Column(
//         children: [
//           Text(currentLocation),
//           MaterialButton(onPressed: (){
//             findLocation();
//           },
//           child: Text("Find Location"),
//           )
//         ],
//       ),
//     );
//   }
//
//   findLocation() {
//     locator.cure
//   }
//
//   // geolocator
//   //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//   //     .then((Position position) {
//   // setState(() {
//   // _currentPosition = position;
//   // });
//   //
//   // _getAddressFromLatLng();
//   // }).catchError((e) {
//   // print(e);
//   // });
// }
