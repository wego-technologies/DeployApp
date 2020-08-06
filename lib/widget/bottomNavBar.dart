import 'package:flutter/material.dart';
import 'package:gategoDeploy/controller/WifiInfo.dart';
import 'package:gategoDeploy/pages/deployPage.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final nextPage;
  final bool backBtn;
  final String textMain;
  final String textSec;
  final IconData iconMain;
  final IconData iconSec;
  final bool goHome;
  final bool checkData;
  BottomNavBar(
    this.nextPage, {
    this.backBtn = true,
    this.textMain = "Next",
    this.textSec = "Back",
    this.iconMain = Icons.arrow_forward,
    this.iconSec = Icons.arrow_back,
    this.goHome = false,
    this.checkData = true,
  });
  final Controller c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (backBtn)
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      iconSec,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(
                      textSec,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                  vertical: 15,
                ),
              ),
            ),
          Expanded(
            child: FlatButton(
              onPressed: () {
                if (checkData) {
                  if (c.checkData()) {
                    Get.to(nextPage);
                  } else {
                    Get.snackbar(
                        "Error",
                        "There are missing details, please make sure you're" +
                            " connected to a Wi-Fi network and you have entered" +
                            " a password.");
                  }
                }
                if (goHome) {
                  Get.offUntil(MaterialPageRoute(builder: (_) {
                    return DeployPage();
                  }), (route) => false);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    textMain,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    iconMain,
                    color: Colors.white,
                  ),
                ],
              ),
              color: Theme.of(context).primaryColor,
              shape: backBtn
                  ? RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(30)),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}
