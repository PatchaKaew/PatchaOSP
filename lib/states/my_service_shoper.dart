import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaewosp/states/list_order.dart';
import 'package:kaewosp/states/list_product.dart';
import 'package:kaewosp/utility/my_style.dart';

class MyserviceShoper extends StatefulWidget {
  @override
  MyserviceShoperState createState() => MyserviceShoperState();
}

class MyserviceShoperState extends State<MyserviceShoper> {
  String nameLogin;
  Widget currentWidget = ListOrder();

  //คืออะไรน้าาา
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameLoginAndTypeUser();
  }

  Future<Null> findNameLoginAndTypeUser() async {
    //เรียกใช้งาน Database ต้องรายงานตัวก่อน
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameLogin = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyStyle().primaryColor,
        title: Text('Shoper'),
      ),
      drawer: Drawer(
        //child: Column(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuListOrder(),
                buildMenuListProduct(),
              ],
            ),
            buildColumnSignOut(context),
          ],
        ),
      ),
      body: currentWidget,
    );
  }

  ListTile buildMenuListOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ListOrder();
        });
        //ปิดออกไปหลังกด
        Navigator.pop(context);
      },
      leading: Icon(Icons.home),
      title: Text('List Order'),
      subtitle: Text('รายการ Order ของลูกค้าที่สั่ง'),
    );
  }

  ListTile buildMenuListProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ListProduct();
        });
        //ปิดออกไปหลังกด
        Navigator.pop(context);
      },
      leading: Icon(Icons.list),
      title: Text('List Product'),
      subtitle: Text('รายการ สินค้า ของฉัน'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      // decoration: BoxDecoration(color: Colors.purple),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(nameLogin == null ? 'Name' : nameLogin),
      accountEmail: Text('Shoper : '),
    );
  }

  Column buildColumnSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MyStyle().buildSignOut(context),
      ],
    );
  }
}
