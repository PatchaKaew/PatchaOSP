

import 'package:flutter/material.dart';
import 'package:kaewosp/states/add_product.dart';
import 'package:kaewosp/states/authen.dart';
import 'package:kaewosp/states/my_service_shoper.dart';
import 'package:kaewosp/states/my_service_user.dart';
import 'package:kaewosp/states/register.dart';



final Map<String, WidgetBuilder> myRoutes = {
  '/authen':(BuildContext context)=>Authen(),
  '/register':(BuildContext context)=>Register(),
  '/myserviceUser':(BuildContext context)=>MyserviceUser(),
  '/myserviceShoper':(BuildContext context)=>MyserviceShoper(),
  '/addProduct':(BuildContext context)=>AddProduct(),
};