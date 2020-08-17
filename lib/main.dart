import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiredash/wiredash.dart';
import 'controller/WifiInfo.dart';
import 'pages/deployPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "deploy-app-5iifjx4",
      secret: "udz6qzwflvh1twain7kr4inooq6hqnz6",
      navigatorKey: Get.key,
      child: GetMaterialApp(
        title: 'gatego Deployer',
        defaultTransition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 150),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff00a1d3),
          buttonColor: Color(0xff00a1d3),
          accentColor: Color(0xff353535),
          appBarTheme: AppBarTheme(
            elevation: 1,
            color: Colors.white,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Color(0xff353535),
            ),
          ),
        ),
        home: DeployPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
