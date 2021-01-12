

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaewosp/router.dart';

// void main() {
//   runApp(Myapp());
// }

main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      //เอาแท็ก Debug ออก
      debugShowCheckedModeBanner: false,
      routes: myRoutes, //ใช้ชื่อเดียวกับที่ตั้งใน route.dart
      initialRoute: '/authen', //หน้าแรกของ Application
    );
  }
}
