import 'dart:math';

import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:get/get.dart';
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
  final Controller c = Get.find();

  Stream<ESPTouchResult> stream;
  var controller = TextEditingController();

  void espSetup() async {
    final task = ESPTouchTask(
      ssid: c.wifiSSID,
      bssid: c.wifiBSSID,
      password: c.wifiPSK,
    );
    stream = task.execute();
    final sub = stream.listen((r) => print('IP: ${r.ip} MAC: ${r.bssid}'));
    Future.delayed(Duration(minutes: 1), () => sub.cancel());
  }

  @override
  Widget build(BuildContext context) {
    String wifiName = c.wifiSSID;
    String wifiBSSID = c.wifiBSSID;
    String wifiPSK = c.wifiPSK;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/gatego.png",
          height: 30,
          alignment: Alignment.centerLeft,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sync,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Great job! Please confirm your connection settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: max(MediaQuery.of(context).size.width * 0.4, 200),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 5,
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
              ],
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
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
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
                    color: Theme.of(context).primaryColor,
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
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
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
    );
  }
}
