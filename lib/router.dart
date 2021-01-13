

import 'package:flutter/material.dart';
import 'package:kaewosp/states/authen.dart';
import 'package:kaewosp/states/my_service_shoper.dart';
import 'package:kaewosp/states/my_service_user.dart';
import 'package:kaewosp/states/register.dart';



final Map<String, WidgetBuilder> myRoutes = {
  '/authen':(BuildContext context)=>Authen(),
  '/register':(BuildContext context)=>Register(),
  '/myserviceUser':(BuildContext context)=>My_serviceUser(),
  '/myserviceShoper':(BuildContext context)=>My_serviceShoper(),
};