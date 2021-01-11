

import 'package:flutter/material.dart';
import 'package:kaewosp/states/authen.dart';
import 'package:kaewosp/states/my_service.dart';
import 'package:kaewosp/states/register.dart';



final Map<String, WidgetBuilder> myRoutes = {
  '/authen':(BuildContext context)=>Authen(),
  '/register':(BuildContext context)=>Register(),
  '/myservice':(BuildContext context)=>My_service()
};