import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final nextPage;
  final bool backBtn;
  BottomNavBar(this.nextPage, {this.backBtn = true});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 5,
        right: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backBtn
              ? FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Back',
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
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                )
              : SizedBox(
                  height: 1,
                ),
          FlatButton(
            onPressed: () => Get.to(nextPage),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Next',
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
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
        ],
      ),
    );
  }
}
