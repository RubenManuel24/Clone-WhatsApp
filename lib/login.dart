 
import 'package:app_clone_whatsapp/cadastro.dart';
import 'package:app_clone_whatsapp/home.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:app_clone_whatsapp/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarLogin(){
   
   if(_controllerEmail.text.isNotEmpty){
     if(_controllerSenha.text.isNotEmpty){

        Usuario usuario = Usuario();
        usuario.setEmail = _controllerEmail.text;
        usuario.setSenha = _controllerSenha.text;
         
         _loginUsuario(usuario);
       
     }
     else{
       setState(() {
         _mensagemErro = "Preenche a Senha!";
       });
     }
     
   }
   else{
       setState(() {
         _mensagemErro = "Preenche o E-mail!";
       });
   }

  }

   _loginUsuario(Usuario usuario){

        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signInWithEmailAndPassword(
          email: usuario.getEmail, 
          password: usuario.getSenha)
          .then((firebaseUser){
              
           return Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_HOME);

          })
          .catchError((erro){

              setState(() {
               _mensagemErro = "Erro ao fazer login, verifique o E-mail ou Senha!";
              });

          });

   }

  Future _verificarUser() async {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  // auth.signOut();
  var usuarioAtual = await auth.currentUser;
  
  if(usuarioAtual != null){
     
     Navigator.pushReplacementNamed(context, RouteGenerator.ROUTE_HOME);
 
  }

  }
  
   @override
   void initState() {
    _verificarUser();
   super.initState();
     
   }

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
                    controller: _controllerEmail,
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
                    controller: _controllerSenha,
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
                    onPressed: (){
                      _validarLogin();
                    }, 
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
              
                       Navigator.pushNamed(context, RouteGenerator.ROUTE_CADASTRO);
                       
                      },
                      child: Text("Não tem conta? cadaste-se!", style: TextStyle( color: Colors.white),),
                    ),
                   ),
                   Padding(padding: EdgeInsets.only(top: 16),
                   child: Center(
                    child: Text(_mensagemErro, 
                     style: TextStyle(color: Colors.red, 
                     fontSize: 12),),
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