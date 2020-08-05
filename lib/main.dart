import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/deployPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      title: 'gatego Deployer',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff00a1d3),
          buttonColor: Color(0xff00a1d3),
          accentColor: Color(0xff353535),
          appBarTheme: AppBarTheme(
            color: Colors.white,
          )),
      home: DeployPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
