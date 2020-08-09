import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import '../pages/fail.dart';
import '../pages/success.dart';
import 'package:get/get.dart';

class SendPage extends StatefulWidget {
  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final Controller c = Get.find();

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
    final sub = stream.listen((r) {
      handleSuccess(r.ip, r.bssid);
    });
    Future.delayed(Duration(seconds: 15), () {
      handleFail(sub);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    espSetup();
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
              onPressed: () {},
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
                  "Sending data...",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.width * 0.6,
                child: FlareActor(
                  "assets/connect.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Untitled",
                ),
              ),
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
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
