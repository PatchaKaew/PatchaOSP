import 'package:flutter/material.dart';

class MyStyle {
  //Color darkColor = Colors.blue[700];
  //  Color primaryColor = Colors.blue;
  // Color lightColor = Colors.yellow;

  Color darkColor = Color(0xff002171);
  Color primaryColor = Color(0xff0d47a1);
  Color lightColor = Color(0xff5472d3);

  Widget showProgress() => Center(child: CircularProgressIndicator());

  TextStyle whiteStyle() => TextStyle(color: Colors.white);

  TextStyle pinkStyle() => TextStyle(color: Colors.pink);

  double findScreen(BuildContext context) {
    return MediaQuery.of(context).size.width; //หาว่าอยู่จอขนาดเท่าไหร่
  }

  MyStyle();
}
