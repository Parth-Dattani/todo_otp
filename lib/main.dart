import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_otp/connectivity/offline.dart';
import 'package:todo_otp/img_carousel.dart';
import 'package:todo_otp/loader/skeleton_effect2.dart';
import 'package:todo_otp/login_screen.dart';
import 'package:todo_otp/paginated_table.dart';
import 'package:todo_otp/qr/bar_codeer.dart';
import 'package:todo_otp/stepper/linear_step.dart';
import 'package:todo_otp/stepper/stepper.dart';
import 'package:upgrader/upgrader.dart';

import 'loader/loder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.purple,
        alignment: Alignment.center,
        child: const Text(
          'Something went wrong!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
          upgrader: Upgrader(
            debugDisplayAlways: false,
            durationUntilAlertAgain: Duration(milliseconds: 4),
          ),
          child: const PaginatedTable()),
          //child: const LoginScreen()),
    );
  }
}
