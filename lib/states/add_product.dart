import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaewosp/utility/dialog.dart';
import 'package:kaewosp/utility/my_style.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  double screen;
  File file;
  String name, destcrip, price;
  bool statusProcess = false;

  Container buildName() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 16), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
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
        onChanged: (value) => destcrip = value.trim(),
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
        keyboardType: TextInputType.number,
        onChanged: (value) => price = value.trim(),
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
      body: Stack(children: [
        statusProcess ? MyStyle().showProgress() : SizedBox(),
        buildSingleChildScrollView(),
      ]),
    );
  }

  SingleChildScrollView buildSingleChildScrollView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          buildRowImage(),
          buildName(),
          buildDescription(),
          buildPrice(),
          buildSaveProduct(),
        ],
      ),
    );
  }

  Container buildSaveProduct() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (file == null) {
            normalDialog(
                context, 'Please Choose Image ? by Click Camera or Gallery');
          } else if ((name?.isEmpty ?? true) ||
              (destcrip?.isEmpty ?? true) ||
              (price?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            confirmSave();
          }
        },
        child: Text('Save Product'),
      ),
    );
  }

  Future<Null> confirmSave() async {
    showDialog(
      //SimpleDialog มี Scrollview
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Image.file(file),
          //title: Text('Name = $name'),
          title: Text(name),
          subtitle: Text(destcrip),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price = $price BTH',
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  uploadImageAndInsertData();
                  setState(() {
                    statusProcess = true;
                  });
                  Navigator.pop(context);
                },
                child: Text('Save Product'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancle',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> chooseSourceImage(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Row buildRowImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseSourceImage(ImageSource.camera)),
        Container(
          width: screen * 0.6,
          child:
              file == null ? Image.asset('images/image.png') : Image.file(file),
        ),
        IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseSourceImage(ImageSource.gallery)),
      ],
    );
  }

  void uploadImageAndInsertData() {}
}
