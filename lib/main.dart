import 'package:crowd_monitoring/flashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crowd Monitoring',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FlashScreen());
  }
}

