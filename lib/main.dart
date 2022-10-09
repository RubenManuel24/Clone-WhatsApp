
import 'package:app_clone_whatsapp/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  FirebaseFirestore db = FirebaseFirestore.instance;

  db.collection("Usuario")
  .doc("001")
  .set({"Nome": "Ruben Manuel", "Idade": "23"});

  runApp(MaterialApp(
    home: Home(),
  ));
}