import 'package:flutter/material.dart';
import 'package:kaewosp/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double screen;
  String typeUser;

  Container buildName() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 50), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Name : ',
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
            Icons.lock_outline,
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
          hintText: 'Password : ',
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

  @override
  Widget build(BuildContext context) {
    screen = MyStyle().findScreen(context);
    return Scaffold(
      //สร้างบาร์ด้านบน
      appBar: AppBar(
        //ใส่สี
        backgroundColor: MyStyle().primaryColor,
        //ใส่ข้อความ
        title: Text('Register'),
      ),
      body: Center(
        //กด Ctrl + . เลือก Wrap with Center
        child: Column(
          children: [
            //กด Ctrl + . เลือก Wrap with Column
            buildName(),
            //typeUser คือ ตัวแปรที่ประกาศไว้ด้านบน
            buildRadioUser(),
            buildRadioShoper(),
            buildUser(),
            buildPassword(),

            //กำหนดแผนที่
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                width: screen,
                color: Colors.grey,
                child: Text('This is Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }

//RadioListTile<String> buildRadioUser() {
  //ใช้ Widget ก็ได้
  Container buildRadioUser() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('Type User For Buyer'),
        title: Text('User'),
        value: 'User', //ค่าคืออะไร
        groupValue: typeUser,
        //กดแล้วได้อะไร
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }

  Container buildRadioShoper() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        subtitle: Text('สำหรับร้านค้าที่ต้องการขายสินค้า'),
        title: Text('Shoper'),
        value: 'Shoper', //ค่าคืออะไร
        groupValue: typeUser,
        //กดแล้วได้อะไร
        onChanged: (value) {
          setState(() {
            typeUser = value;
          });
        },
      ),
    );
  }
}
