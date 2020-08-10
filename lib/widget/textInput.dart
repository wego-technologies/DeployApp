import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final Function setData;
  const TextInput(this.setData, {Key key}) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController controller = TextEditingController();
  final _focusNode = FocusNode();
  var colorIcon = Color(0xffd8d8d8);
  var colorShadow = Color(0xffe6e6e6);
  double blurRadius = 5;
  double spreadRadius = 1;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          colorIcon = Color(0xff00a1d3);
          colorShadow = Color(0xffb2e3f2);
          blurRadius = 2;
          spreadRadius = 5;
        });
      } else {
        setState(() {
          colorIcon = Color(0xffd8d8d8);
          colorShadow = Color(0xffe6e6e6);
          blurRadius = 5;
          spreadRadius = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = 16.0;
    var size = MediaQuery.of(context).size.width - padding * 2;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          //color: Color(0xfff5f5f5),
          width: size,
          height: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: blurRadius,
                  spreadRadius: spreadRadius,
                  color: colorShadow)
            ],
            borderRadius: BorderRadius.circular(15),
            color: Color(0xfff5f5f5),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.wifi,
                size: 25,
                color: colorIcon,
              ),
              Expanded(
                //width: size * 0.9,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(15)),
                  child: TextField(
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      fillColor: Color(0xfff5f5f5),
                      focusColor: Color(0xfff5f5f5),
                      hoverColor: Color(0xfff5f5f5),
                      filled: true,
                      border: InputBorder.none,
                      hintText: "Network",
                      hintStyle: TextStyle(
                          color: Color(0xff727272),
                          fontWeight: FontWeight.w300),
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
