import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaewosp/models/product_model.dart';
import 'package:kaewosp/utility/my_constant.dart';
import 'package:kaewosp/utility/my_style.dart';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List<ProductModel> productModels = List();

  double screen;

  //คืออะไรน้าาา
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllProduct();
  }

  Future<Null> readAllProduct() async {
    if (productModels.length != 0) {
      productModels.clear();
    }
    //print('######## Read All Product Work');

    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        print('++++++++++++Read All Product Work uid = $uid');

        String urlAPI =
            'https://www.androidthai.in.th/osp/getProductWhereUidKeaw.php?isAdd=true&uid=$uid';

        await Dio().get(urlAPI).then((value) {
          print('value = $value');
          var result = json.decode(value.data);
          print('result = $result');
          for (var item in result) {
            ProductModel model = ProductModel.fromMap(item);
            setState(() {
              productModels.add(model);
            });
          }
        });
      });
    });
  }

  String cutDetail(String string) {
    String result = string;
    if (result.length >= 60) {
      result = result.substring(0, 59);
      result = '$result ...';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;

    return Scaffold(
      //ใส่ปุ่มเพิ่มสินค้า
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyStyle().primaryColor,
          onPressed: () => Navigator.pushNamed(context, '/addProduct')
              .then((value) => readAllProduct()),
          child: Icon(Icons.add)),

// body: Text('This is List Product'),
      body: productModels.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: productModels.length,
              itemBuilder: (context, index) => Card(
                color: index % 2 == 0
                    ? MyStyle().lightColor
                    : Colors.grey.shade300,
                child: Row(
                  children: [
                    Container(padding: EdgeInsets.all(8),
                        width: screen * 0.5 - 5,
                        height: screen * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productModels[index].name,
                              style: MyStyle().titleH1Style(),
                            ),
                            Text(
                              '${productModels[index].price} BTH',
                              style: MyStyle().titleH0Style(),
                            ),
                            Text(cutDetail(productModels[index].detail)),
                          ],
                        )),
                    Container(padding: EdgeInsets.all(8),
                        width: screen * 0.5 - 5,
                        height: screen * 0.5,
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Image.asset('images/image.png'),
                            placeholder: (context, url) =>
                                MyStyle().showProgress(),
                            imageUrl:
                                '${MyConstant().domain}${productModels[index].urlproduct}'))
                  ],
                ),
              ),
            ),
    );
  }
}
