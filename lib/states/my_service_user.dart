import 'package:flutter/material.dart';
import 'package:kaewosp/utility/my_style.dart';

class MyserviceUser extends StatefulWidget {
  @override
  MyserviceUserState createState() => MyserviceUserState();
}

class MyserviceUserState extends State<MyserviceUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      drawer: Drawer(
        child: Column(
          //ทำให้ลงไปอยู่ข้างล่าง
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyStyle().buildSignOut(context),
          ],
        ),
      ),
    );
  }
}
