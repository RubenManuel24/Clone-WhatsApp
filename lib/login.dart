import 'dart:ui';

import 'package:app_clone_whatsapp/cadastro.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            padding: EdgeInsets.all(16),
            color: Color(0xff075E54),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Image.asset("imagens/logo.png", width: 200, height: 150,),
                      ),
                   Padding(padding: EdgeInsets.only(bottom: 8),
                   child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "E-mail",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                      )
                    ),
                   ),
                   Padding(padding: EdgeInsets.only(top: 10, bottom: 16),
                   child: TextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                    hintText: "Senha",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                    ),
                   ),
                   ),
                   Padding(padding: EdgeInsets.only(bottom:10 ),
                   child: TextButton(
                    onPressed: (){}, 
                    child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 20),),
                    style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(32, 16, 32, 16)
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        )
                      )
                    )
                    ),
                   ),
                   Center(
                    child: GestureDetector(
                      onTap: (){
                       Navigator.push(
                        context,
                         MaterialPageRoute(
                          builder: (context) => Cadastro()
                          )
                         );
                      },
                      child: Text("Não tem conta? cadaste-se!", style: TextStyle( color: Colors.white),),
                    ),
                   )
                  ],
                ),
              ),
            ),

          ),
    );
  }
}