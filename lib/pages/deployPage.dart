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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Image.asset(
              "assets/gatego.png",
              height: 30,
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync,
              color: Color(0xff00a1d3),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            VerticalText(),
            TextLogin(),
          ]),
          SSIDInput(),
        ],
      ),
    );
  }
}
