

import 'package:app_clone_whatsapp/home.dart';
import 'package:app_clone_whatsapp/login.dart';
import 'package:app_clone_whatsapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

final ThemeData themePadrao = ThemeData(
      primaryColor: Color(0xff075E54), 
    );

final ThemeData themeIOS = ThemeData(
      primaryColor: Colors.grey[200] 
    );

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home:Login(),
    theme: Platform.isIOS ? themeIOS : themePadrao,
    initialRoute: "/",
    onGenerateRoute:RouteGenerator.generatorRoute ,
    debugShowCheckedModeBanner: false,
  ));
}