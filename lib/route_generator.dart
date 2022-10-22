import 'package:app_clone_whatsapp/cadastro.dart';
import 'package:app_clone_whatsapp/home.dart';
import 'package:app_clone_whatsapp/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static const ROUTE_LOGIN = "/login";
  static const ROUTE_CADASTRO = "/cadastro";
  static const ROUTE_HOME = "/home";


  static Route<dynamic>? generatorRoute(RouteSettings settings){
    switch(settings.name){
      case "/": 
      return MaterialPageRoute(builder: 
        (context) => Login()
      );
      case ROUTE_LOGIN:
      return MaterialPageRoute(builder: 
        (context) => Login()
      );
      case ROUTE_CADASTRO:
      return MaterialPageRoute(builder: 
        (context) => Cadastro ()
      );
      case ROUTE_HOME:
      return MaterialPageRoute(builder: 
        (context) => Home()
      );
      default: 
        _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute(){
     
    return MaterialPageRoute(builder: 
      (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Erro, rota não existente!") ,
          ),
          body: Center(child: Text("Erro, rota não existente!") ),
        );
      }
    );

  }

}
