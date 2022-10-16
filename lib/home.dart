

import 'package:app_clone_whatsapp/telas/contatos.dart';
import 'package:app_clone_whatsapp/telas/conversas.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ) ,
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          tabs: [
            Tab(text: "Convesas",),
            Tab(text: "Contatos",)
          ]
          ),
        backgroundColor:Color(0xff075E54) ,
        title: Text("WhatsApp"),
      ),

      body: TabBarView(
        controller: _tabController ,
        children: [
          Conversas(),
          Contatos()
        ]
          
        ),
    );
  }
} 