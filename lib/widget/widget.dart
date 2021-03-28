import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
  );
}



TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 17);
}

var inputDecoration = InputDecoration(
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(color: Colors.red, width: 2.0)),
  fillColor: Colors.white.withOpacity(0.2),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(width: 1, color: Colors.yellow),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(color: Color(0xFF04BFAD), width: 2.0),
  ),
);