import 'dart:math';

import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/material.dart';
import '../pages/sendPage.dart';
import '../widget/verticalText.dart';
import '../widget/textLogin.dart';

class ConfirmPage extends StatefulWidget {
  final String wifiName;
  final String wifiBSSID;
  final String wifiPSK;

  ConfirmPage(this.wifiBSSID, this.wifiName, this.wifiPSK);
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  String wifiName;
  String wifiBSSID;
  String wifiPSK;

  Stream<ESPTouchResult> stream;
  var controller = TextEditingController();

  void espSetup() async {
    print(wifiName);
    print(wifiBSSID);
    print(wifiPSK);

    final task = ESPTouchTask(
      ssid: wifiName,
      bssid: wifiBSSID,
      password: wifiPSK,
    );
    stream = task.execute();
    final sub = stream.listen((r) => print('IP: ${r.ip} MAC: ${r.bssid}'));
    Future.delayed(Duration(minutes: 1), () => sub.cancel());
  }

  @override
  Widget build(BuildContext context) {
    wifiName = widget.wifiName;
    wifiBSSID = widget.wifiBSSID;
    wifiPSK = widget.wifiPSK;
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
                "assets/gatego.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Row(children: <Widget>[
                VerticalText(),
                TextLogin(),
              ]),
              Text(
                'Confirm Connection Settings',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: max(MediaQuery.of(context).size.width * 0.4, 200),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  shadowColor: Colors.blue[300],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.wifi,
                              size: 30,
                            ),
                            Text(wifiName)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.vpn_key,
                              size: 30,
                            ),
                            Text(wifiPSK)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.all_out,
                              size: 30,
                            ),
                            Text(wifiBSSID)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[300],
                          blurRadius:
                              10.0, // has the effect of softening the shadow
                          spreadRadius:
                              1.0, // has the effect of extending the shadow
                          offset: Offset(
                            5.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                SendPage(wifiBSSID, wifiName, wifiPSK),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Deploy',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.lightBlueAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
