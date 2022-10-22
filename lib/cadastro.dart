import 'package:app_clone_whatsapp/home.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:app_clone_whatsapp/route_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  
  String _mensagemErro = "";

  _validarCadastro(){ 
    if(_controllerNome.text.isNotEmpty){
       if(_controllerNome.text.length > 4){
        if(_controllerEmail.text.isNotEmpty){
          if(_controllerEmail.text.contains("@")){
             if( _controllerSenha.text.isNotEmpty){
                if( _controllerSenha.text.length >= 6){

                   Usuario usuario = Usuario();
                   usuario.setNome  = _controllerNome.text;
                   usuario.setEmail = _controllerEmail.text;
                   usuario.setSenha = _controllerSenha.text;

                   _cadastraUsuario(usuario);

                }
                else{
                     setState(() {
                       _mensagemErro = "A Senha tem que ter mais de 5 digitos";
                     });
               }
             } 
             else{
                  setState(() {
                    _mensagemErro = "Preencha a Senha";
                 });
            }

          }
          else{
               setState(() {
                 _mensagemErro = "O E-mail tem que conter @";
              });
         }

        } 
        else{
         setState(() {
             _mensagemErro = "Preencha o E-mail";
         });
       }

       }
       else{
             setState(() {
               _mensagemErro = "O Nome tem que ter mais de 4 digitos";
             });
    }

    }
    else{
         setState(() {
             _mensagemErro = "Preencha o Nome";
         }); 
    }
  }


  _cadastraUsuario(Usuario usuario){

  FirebaseAuth auth = FirebaseAuth.instance;
  
  auth.createUserWithEmailAndPassword(
    email: usuario.getEmail, 
    password: usuario.getSenha
    ).then((firebaseUser) {
     
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Usuario")
      .doc(firebaseUser.user?.uid)
      .set(usuario.toMap());

      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.ROUTE_HOME, (_) => false);

    }).catchError((erro){
         
        setState(() {
                      _mensagemErro = "Erro ao cadastrar-se verifica o E-mail ou a Senha!";
                  });
    });
   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Text("Cadastro"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xff075E54),
        child: Center(
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 16),
                child: Image.asset("imagens/usuario.png", width: 150, height: 150),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: _controllerNome,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Nome",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 16),
                child: TextField(
                  controller:  _controllerSenha,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),
                child: TextButton(
                  onPressed: (){
                    _validarCadastro();
                  }, 
                  child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontSize: 20)),
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.fromLTRB(32, 16, 32, 16),
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
                  child: Text(_mensagemErro, 
                  style: TextStyle( 
                    color: Colors.red,
                    fontSize: 12
                    ),
                    ),
                 )
              ]
              ),
          )
        ),
      ),
    );
  }
}
