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
      ),
      home: DeployPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
