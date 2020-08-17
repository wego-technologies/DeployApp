import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:gategoDeploy/pages/deployPage.dart';
import 'package:gategoDeploy/widget/bottomNavBar.dart';
import 'package:package_info/package_info.dart';
import 'package:wiredash/wiredash.dart';

class FailPage extends StatelessWidget {
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
              color: Color(0xff00a1d3),
            ),
            onPressed: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();

              String version = packageInfo.version;
              String buildNumber = packageInfo.buildNumber;
              Wiredash.of(context)
                  .setIdentifiers(appVersion: version + " B" + buildNumber);
              Wiredash.of(context).show();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        DeployPage(),
        backBtn: false,
        textMain: "Re-try ",
        iconMain: Icons.sync,
        goHome: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Error",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: FlareActor(
                  "assets/error.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  isPaused: false,
                  animation: "pago_problema_sin_conexion",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Failed to set up device.",
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
            ],
          ),
        ),
      ),
    );
  }
}
