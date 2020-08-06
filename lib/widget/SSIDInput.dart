import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:get/get.dart';

class SSIDInput extends StatefulWidget {
  @override
  _SSIDInputState createState() => _SSIDInputState();
}

class _SSIDInputState extends State<SSIDInput> {
  final Controller c = Get.find();
  String wifiName;
  String wifiBSSID;
  String wifiPSK;
  var controller = TextEditingController();

  final Connectivity _connectivity = Connectivity();

  void wifi() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    if (permission == PermissionStatus.granted) {
      wifiName = await _connectivity.getWifiName();
      wifiBSSID = await _connectivity.getWifiBSSID();
      c.setSSID(wifiName);
      c.setBSSID(wifiBSSID);
    } else {
      await LocationPermissions().requestPermissions();
      wifi();
    }
    if (wifiName != null) {
      controller.text = wifiName;
    } else {
      c.setWifi(bssid: "", ssid: "", psk: "");
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
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (val) => c.setSSID(val),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: TextField(
              onChanged: (val) => c.setPSK(val),
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
      ],
    );
  }
}
