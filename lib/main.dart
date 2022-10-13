

import 'package:app_clone_whatsapp/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
    

  runApp(MaterialApp(
    home:Login(),
    theme: ThemeData(
      primaryColor: Color(0xff075E54), 
    ),
  ));
}