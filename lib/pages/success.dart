import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/pages/deployPage.dart';
import 'package:gategoDeploy/widget/bottomNavBar.dart';

class SuccessPage extends StatelessWidget {
  final String ip;
  final String bssid;
  SuccessPage(this.ip, this.bssid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/gatego.png",
          height: 30,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        DeployPage(),
        backBtn: false,
        textMain: "Re-deploy ",
        iconMain: Icons.play_for_work,
        goHome: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: FlareActor(
                "assets/success.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                isPaused: false,
                animation: "Untitled",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Successfully set up device.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
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
                          Text(ip)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.all_out,
                            size: 30,
                          ),
                          Text(bssid)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
