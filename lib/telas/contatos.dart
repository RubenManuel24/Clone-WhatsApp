import 'package:app_clone_whatsapp/model/conversa.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  
 var _emailUserLogado;

//Metodo para capturar os contados
Future<List<Usuario>> _recuperarContatos() async {
 
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection("Usuario").get();

    List<Usuario> listaUsuario = [];
    for(var item in querySnapshot.docs){

          var dados = item;

        if(dados["email"] == _emailUserLogado)  continue;
        
          Usuario usuario = Usuario();
          usuario.setEmail = dados["email"];
          usuario.setNome = dados["nome"];
          usuario.setUrlImagem = dados["urlImagem"];

          listaUsuario.add(usuario);
    }
      return listaUsuario;
}

Future _recuperUserLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    var userLogado = auth.currentUser;

    _emailUserLogado = userLogado?.email;

}

@override
void initState() {
  super.initState();
 _recuperUserLogado();
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
      future: _recuperarContatos(),
      builder: (_, snapshot){
        switch(snapshot.connectionState){

          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
               child: Center(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 100, bottom: 30),
                    child: Text("Carregando Contatos..."),),
                    CircularProgressIndicator(color: Colors.green,),
                  ]
                  ),
               ),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index){

                 List<Usuario> listaItens = snapshot.requireData;
                 Usuario usuario = listaItens[index];
            
              return ListTile(
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: 
                   NetworkImage(usuario.getUrlImagem)
                ),
                title: Text( usuario.getNome,
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                  
                ),
          );
          });
        }
      }
      );
  }
}

//
