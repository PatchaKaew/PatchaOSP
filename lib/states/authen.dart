import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaewosp/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen; //ประกาศตัวแปรใช้แค่ใน Class
  bool status = true; //ประกาศตัวแปรมีค่า true flase

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width; //หาตัวแปรว่าอยู่จอขนาดเท่าไหร่
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
        onPressed: () {},
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
        onPressed: () {},
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
        style: GoogleFonts.caveat(
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
}
