//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kaewosp/models/user_model.dart';
import 'package:kaewosp/utility/dialog.dart';
import 'package:kaewosp/utility/my_style.dart';
import 'package:location/location.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //ประกาศตัวแปร
  double screen;
  String typeUser, token, name, user, password;
  double lat, lng;
  bool statusProcess = false;

//ทำงานก่อน Build
  @override
  void initState() {
    super.initState();
    findLatLng(); //หาพิกัด
    findToken();
  }

  Future<Null> findToken() async {
    // await Firebase.initializeApp().then((value) {
    //   print('#########Initialize Success###########');
    // });

    FirebaseMessaging messaging = FirebaseMessaging();
    token = await messaging.getToken();
    print('token = ##########$token');
  }

  //ทำงานรอผลลัพธ์ ถ้า Method ทำงานแล้วไม่บอกผลลัพธ์
  Future<Null> findLatLng() async {
    LocationData data = await findLocationData();
    setState(() {
      lat = data.latitude;
      lng = data.longitude;
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Container buildName() {
    return Container(
      //ใส่สีขาวให้ TextField
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 50), //กำหนดระยะห่าง
      width: screen * 0.6,
      child: TextField(
        //get ค่าจาก textfield
        onChanged: (value) => name = value.trim(),
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
        onChanged: (value) => user = value.trim(),
        //กำหนดคีย์บอร์ด
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.email_outlined,
            color: MyStyle().darkColor,
          ), //ใส่ icon ใน textfield
          hintText: 'Email : ',
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
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor), //ใส่สีให้ hintStyle
          prefixIcon: Icon(
            Icons.lock_outline,
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
        actions: [
          IconButton(
              icon: Icon(Icons.cloud_upload_outlined),
              onPressed: () {
                print(
                    'name = $name, user =$user, password = $password, typeUser = $typeUser');
                //เช็คค่าว่าง และไม่กรอกข้อมูล
                if ((name == null || name.isEmpty) ||
                    (user?.isEmpty ?? true) ||
                    (password?.isEmpty ?? true)) {
                  normalDialog(context, 'Have Space ? Please Fill Every Blank');
                } else if (typeUser == null) {
                  normalDialog(context, 'Type User ? Please Choose Type User');
                } else {
                  setState(() {
                    statusProcess = true;
                  });
                  registerAndInsertData();
                }
              })
        ],
        //ใส่สี
        backgroundColor: MyStyle().primaryColor,
        //ใส่ข้อความ
        title: Text('Register'),
      ),
      body: Stack(
        children: [
          statusProcess ? MyStyle().showProgress() : SizedBox(),
          buildContent(),
        ],
      ),
    );
  }

  Center buildContent() {
    return Center(
      //กด Ctrl + . เลือก Wrap with Center
      //ใส่ Scrollview
      child: SingleChildScrollView(
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
            buildMap(),
          ],
        ),
      ),
    );
  }

  //มี Marker ได้มากกว่า 1 ตัว
  Set<Marker> markers() => <Marker>[
        Marker(
          markerId: MarkerId('idMarker1'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat =$lat, Lng=$lng'),
        ),
      ].toSet();

  //Map
  Widget buildMap() {
    return Container(
      margin: EdgeInsets.all(16),
      width: screen,
      height: screen * 0.6,
      //color: Colors.grey,
      //if else แบบสั้น
      child: lat == null
          ? MyStyle().showProgress()
          : GoogleMap(
              markers: markers(),
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 16,
              ),
              onMapCreated: (controller) {},
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

  //Return ค่ากลับ
  Future<Null> registerAndInsertData() async {
    //เช็คว่ามีสิทธิ์หรือไม่ ถ้าใช้ await ซ้อน ต้องมี async
    await Firebase.initializeApp().then((value) async {
      print('##########Initial Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          //ถ้าสมัครสมาชิกสำเร็จจะให้บันทึกที่ database
          .then((value) async {
        String uid = value.user.uid;
        print('#########Register Success uid =$uid');

        await value.user.updateProfile(displayName: name);

        Map<String, dynamic> map = Map();
        map['typeuser'] = typeUser;

        await FirebaseFirestore.instance
            .collection('typeuser')
            .doc(uid)
            .set(map);
        // = class ที่สร้างไว้ใน Model
        UserModel model = UserModel(
            email: user,
            lat: lat.toString(),
            lng: lng.toString(),
            name: name,
            token: token);
        Map<String, dynamic> data = model.toMap();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(typeUser)
            .collection('information')
            .doc(uid)
            .set(data)
            .then((value) => Navigator.pop(context));
      })
          //ถ้าไม่สำเร็จจะทำอะไร
          .catchError((value) {
        setState(() {
          statusProcess = false;
        });
        normalDialog(context, value.message);
      });
    });
  }
}
