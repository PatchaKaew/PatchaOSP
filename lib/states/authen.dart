import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaewosp/utility/dialog.dart';
import 'package:kaewosp/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen; //ประกาศตัวแปรใช้แค่ใน Class
  bool status = true; //ประกาศตัวแปรมีค่า true flase
  String user, password;

  @override
  Widget build(BuildContext context) {
    //screen = MediaQuery.of(context).size.width; //หาตัวแปรว่าอยู่จอขนาดเท่าไหร่
    screen = MyStyle().findScreen(context);
    print('screen = $screen'); //print ค่าหน้าจอออกมาดู
    return Scaffold(
      floatingActionButton: buildRegister(),
      body: Container(
        decoration: BoxDecoration(
            //ใส่สีพื้นหลัง
            gradient: RadialGradient(
                center: Alignment(0, -0.30), //ขยับสีขาวให้ตรงโลโก้
                radius: 1.0,
                colors: <Color>[Colors.white, MyStyle().primaryColor])),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildText(),
              buildUser(),
              buildPassword(),
              //เพิ่มปุ่ม
              buildLogin(),
            ],
          ),
        ),
      ), //จัดกึ่งกลาง
    );
  }

  FlatButton buildRegister() {
    return FlatButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/register'), //ลิ้งค์ไปหน้าใหม่
        child: Text(
          'New Register',
          style: MyStyle().pinkStyle(),
        ));
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16), //ระยะห่าง
      width: screen * 0.6, //ความกว้าง
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: MyStyle().darkColor, //ใส่สีให้ปุ่ม
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'กรอกข้อมูลค่ะ เว้นว่างไว้ทำไม');
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'Log in',
          style: MyStyle().whiteStyle(),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'User : ',
          enabledBorder: OutlineInputBorder(
              //โชว์ปกติ
              borderRadius: BorderRadius.circular(20), //ทำให้โค้ง
              borderSide: BorderSide(color: MyStyle().darkColor)), //ใส่ขอบ
          focusedBorder: OutlineInputBorder(
              //ตอนคลิก
              borderRadius: BorderRadius.circular(20), //ทำให้โค้ง
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: status, //ไม่แสดงรหัส
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: status
                  ? Icon(Icons.remove_red_eye)
                  : Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  status = !status; //กดแล้วจะเป็นค่าตรงข้าม
                }); //ให้ Refresh หน้้าจอใหม่
                print('You lick RedEye status = $status');
              }), //กดให้แสดงรหัส
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Password : ',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)), //ใส่ขอบ
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'PATCHA OSP',
        style: GoogleFonts.concertOne(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: MyStyle().darkColor,
        )),
      );

  Container buildLogo() {
    return Container(
      width: screen * 0.33,
      child: Image.asset('images/logo.png'),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        //Login ด้วย Type อะไร
        String uid = value.user.uid;

        print('xxxxxx uid = $uid');
//อ่านค่าจากฐานข้อมูล
        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .snapshots()
            .listen((event) {
          String typeUser = event.data()['typeuser'];
          print('***************typeuser = $typeUser');


          Navigator.pushNamedAndRemoveUntil(
            context, '/myservice$typeUser', (route) => false);


        });

        
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
