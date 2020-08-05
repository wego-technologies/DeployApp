import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../pages/confirmPage.dart';
import 'package:get/get.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:esptouch_flutter/esptouch_flutter.dart';

class SSIDInput extends StatefulWidget {
  @override
  _SSIDInputState createState() => _SSIDInputState();
}

class _SSIDInputState extends State<SSIDInput> {
  String wifiName;
  String wifiBSSID;
  String wifiPSK;
  Stream<ESPTouchResult> stream;
  var controller = TextEditingController();

  final Connectivity _connectivity = Connectivity();

  void wifi() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    if (permission == PermissionStatus.granted) {
      wifiName = await _connectivity.getWifiName();
      wifiBSSID = await _connectivity.getWifiBSSID();
    } else {
      await LocationPermissions().requestPermissions();
      wifi();
    }
    if (wifiName != null) {
      controller.text = wifiName;
    } else {
      wifiName = "";
      wifiBSSID = "";
      wifiPSK = "";
    }
  }

  @override
  void initState() {
    super.initState();
    wifi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => wifiName = val,
                    controller: controller,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      fillColor: Colors.lightBlueAccent,
                      labelText: 'Network Name',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.sync,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () => wifi(),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: TextField(
              onChanged: (value) {
                wifiPSK = value;
              },
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              obscureText: true,
              decoration: InputDecoration(
                focusColor: Theme.of(context).primaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
          child: Container(
            alignment: Alignment.bottomRight,
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: FlatButton(
              onPressed: () {
                print(wifiBSSID);
                print(wifiName);
                print(wifiPSK);
                try {
                  if (wifiBSSID.isNotEmpty &&
                      wifiName.isNotEmpty &&
                      wifiPSK.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ConfirmPage(wifiBSSID, wifiName, wifiPSK),
                      ),
                    );
                  } else {
                    Get.snackbar("Error", "Missing details, please try again.");
                  }
                } on NoSuchMethodError {
                  Get.snackbar("Error", "Missing details, please try again.");
                }
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
        ),
      ],
    );
  }
}
