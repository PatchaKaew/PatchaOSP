import 'package:flutter/material.dart';
import 'package:kaewosp/router.dart';

// void main() {
//   runApp(Myapp());
// }

main() => runApp(Myapp());


class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: myRoutes, //ใช้ชื่อเดียวกับที่ตั้งใน route.dart
      initialRoute: '/authen', //หน้าแรกของ Application
    );
  }
}
