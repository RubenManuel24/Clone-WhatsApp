

import 'package:app_clone_whatsapp/login.dart';
import 'package:app_clone_whatsapp/route_generator.dart';
import 'package:app_clone_whatsapp/telas/contatos.dart';
import 'package:app_clone_whatsapp/telas/conversas.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  List<String> _item = [
    "Configuações", "Deslogar"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, 
      vsync: this);
  }
  
  _itemSelecionado(String escolhaItem){
     switch(escolhaItem){
       case "Configuações":
          print("Configuações feita!");
          break;
       case "Deslogar":
          _deslogarUser();
          break;
     }
  }

  _deslogarUser()async {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();

   Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_LOGIN);

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
        actions: [
          PopupMenuButton<String>(
            onSelected: _itemSelecionado,
            itemBuilder: (context){
              return _item.map((String item) {
                 return PopupMenuItem(
                  value: item,
                  child: Text(item),
                  );
              }).toList();
          },
        )
      ],
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