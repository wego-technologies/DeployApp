import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:gategoDeploy/widget/bottomNavBar.dart';
import 'package:get/get.dart';
import '../pages/sendPage.dart';
import 'deployPage.dart';

class ConfirmPage extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    String wifiName = c.wifiSSID;
    String wifiBSSID = c.wifiBSSID;
    String wifiPSK = c.wifiPSK;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(SendPage()),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            onPressed: () {
              Get.offUntil(MaterialPageRoute(builder: (_) {
                return DeployPage();
              }), (route) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Confirm Settings",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: FlareActor(
                "assets/waiting.flr",
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: "Alarm",
              ),
            ),
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
                    //shadowColor: Theme.of(context).primaryColor,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
