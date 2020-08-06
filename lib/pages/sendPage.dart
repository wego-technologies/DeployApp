import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import '../pages/fail.dart';
import '../pages/success.dart';
import '../widget/verticalText.dart';
import '../widget/textLogin.dart';
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
                LinearProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sending data to the device',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'This may take some time',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
      ),
    );
  }
}
