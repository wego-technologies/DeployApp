import 'dart:async';

import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:package_info/package_info.dart';
import 'package:wiredash/wiredash.dart';
import '../pages/fail.dart';
import '../pages/success.dart';
import 'package:get/get.dart';

import 'deployPage.dart';

class SendPage extends StatefulWidget {
  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final Controller c = Get.find();
  StreamSubscription<ESPTouchResult> sub;

  bool completed = false;

  void handleSuccess(ip, bssid) {
    completed = true;
    Get.to(SuccessPage(ip, bssid));
  }

  void handleFail(sub) async {
    sub.cancel();
    print("cancelled!!!!");
    if (!completed) {
      Get.off(FailPage());
    }
  }

  void espSetup() async {
    final info = c.wifiInfo();
    print("WiFi: " + info["SSID"]);
    print("BSSID: " + info["BSSID"]);
    print("PSK: " + info["PSK"]);

    final task = ESPTouchTask(
      ssid: info["SSID"],
      bssid: info["BSSID"],
      password: info["PSK"],
    );
    final stream = task.execute();
    sub = stream.listen((r) {
      handleSuccess(r.ip, r.bssid);
    });
    Future.delayed(Duration(seconds: 60), () {
      handleFail(sub);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    espSetup();
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
              onPressed: () {
                handleFail(sub);
                Get.offUntil(MaterialPageRoute(builder: (_) {
                  return DeployPage();
                }), (route) => false);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.chat,
                color: Color(0xff00a1d3),
              ),
              onPressed: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();

                String version = packageInfo.version;
                String buildNumber = packageInfo.buildNumber;
                Wiredash.of(context).setBuildProperties(
                    buildVersion: version, buildNumber: buildNumber);
                Wiredash.of(context).show();
              },
            ),
          ],
          bottom: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              "Sending data...",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: FlareActor(
                  "assets/aio_indicator.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "loading",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Sending data to the device',
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'This may take some time',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.all(8),
                color: Color(0xffffcd91),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(0xffd97700),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "Please make sure that your device is connected to " +
                              c.wifiSSID +
                              " or the proccess won't complete. If it fails check that the hardware is in SmartDeploy mode and try again. For further support email eduardo@wegotech.io",
                          maxLines: 5,
                          style: TextStyle(
                            color: Color(0xffd97700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
