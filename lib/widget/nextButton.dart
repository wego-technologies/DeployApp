import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:gategoDeploy/pages/confirmPage.dart';
import 'package:get/get.dart';

class NextButton extends StatelessWidget {
  final Controller c = Get.put(Controller());

  NextButton({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {
            print(c.wifiBSSID);
            try {
              if (c.wifiBSSID.isNotEmpty &&
                  c.wifiSSID.isNotEmpty &&
                  c.wifiPSK.isNotEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ConfirmPage(c.wifiBSSID, c.wifiSSID, c.wifiPSK),
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
                text,
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
    );
  }
}
