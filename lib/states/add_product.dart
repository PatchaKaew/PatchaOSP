import 'package:flutter/material.dart';
import 'package:kaewosp/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double screen;

  Container buildName() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.card_giftcard,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Name Product : ',
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

  Container buildDescription() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.description,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Description : ',
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

  Container buildPrice() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.money,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Price : ',
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
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildRowImage(),
            buildName(),
            buildDescription(),
            buildPrice(),
            buildSaveProduct(),
          ],
        ),
      ),
    );
  }

  Container buildSaveProduct() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text('Save Product'),
      ),
    );
  }

  Row buildRowImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {}),
        Container(
          width: screen * 0.6,
          child: Image.asset('images/image.png'),
        ),
        IconButton(icon: Icon(Icons.add_photo_alternate), onPressed: () {}),
      ],
    );
  }
}
