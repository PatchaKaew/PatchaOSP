import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaewosp/router.dart';

//ประกาศตัวแปรแบบไม่รู้ว่า data type คืออะไร
var initialRoute;
Future<Null> main() async {
  //ให้ทำเทรดเสร็จก่อนแล้วถึงรัน
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        initialRoute = '/authen';
        runApp(Myapp());
      } else {
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          String typeUser = event.data()['typeuser'];
          initialRoute = '/myservice$typeUser';
          runApp(Myapp());
        });
      }
    });
  });
}

// main() => runApp(Myapp());

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
      initialRoute: initialRoute, //หน้าแรกของ Application
    );
  }
}
