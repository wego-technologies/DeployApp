import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:gategoDeploy/widget/textInput.dart';
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
  var pskController = TextEditingController();
  var ssidFocus = FocusNode();
  var pskFocus = FocusNode();

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
  void dispose() {
    super.dispose();
    pskController.dispose();
    ssidFocus.dispose();
    pskFocus.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              child: TextInput(
                setData: c.setSSID,
                icon: Icons.wifi,
                text: "Network Name",
                c: controller,
                fn: ssidFocus,
                nextFocus: (v) => FocusScope.of(context).requestFocus(pskFocus),
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
        SizedBox(
          height: 20,
        ),
        TextInput(
          setData: c.setPSK,
          c: pskController,
          icon: Icons.vpn_key,
          text: "Password",
          obscureText: true,
          fn: pskFocus,
          nextFocus: (v) {
            if (c.checkData()) {
              FocusScope.of(context).unfocus();
            } else {
              Get.snackbar(
                  "Error",
                  "There are missing details, please make sure you're" +
                      " connected to a Wi-Fi network and you have entered" +
                      " a password.");
            }
          },
        )
      ],
    );
  }
}
