import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widget/SSIDInput.dart';
import '../widget/verticalText.dart';
import '../widget/textLogin.dart';

class DeployPage extends StatefulWidget {
  @override
  _DeployPageState createState() => _DeployPageState();
}

class _DeployPageState extends State<DeployPage> {
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff0CD9C4), Color(0xff00A9DE)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Row(children: <Widget>[
                VerticalText(),
                TextLogin(),
              ]),
              SSIDInput(),
            ],
          ),
        ),
      ),
    );
  }
}
