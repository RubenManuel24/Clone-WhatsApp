

import 'package:app_clone_whatsapp/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
      

  runApp(MaterialApp(
    home:Login(),
    theme: ThemeData(
      primaryColor: Color(0xff075E54), 
    ),
  ));
}