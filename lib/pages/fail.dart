import 'package:flutter/material.dart';
import '../widget/textLogin.dart';
import '../widget/verticalText.dart';

class FailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffED213A), Color(0xff00A9DE)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/gatego.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Row(
                children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.close,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Failed to set up device.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[300],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            1.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Retry',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.cached,
                          color: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
