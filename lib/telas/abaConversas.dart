import 'dart:async';
import 'dart:ui';
import 'package:app_clone_whatsapp/model/conversa.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:app_clone_whatsapp/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {

//controller para Stream
final _controller = StreamController<QuerySnapshot>.broadcast();
FirebaseFirestore db = FirebaseFirestore.instance;
var _idUserLogado;

//Metodo para add um houvinte para a nossa estrutura de conversa do FireBase
Stream<QuerySnapshot>? _addListnerConversa(){
   final stream = db.collection("conversa")
                  .doc( _idUserLogado )
                  .collection("ultima_conversa")
                  .snapshots().listen((dados) { 
                    _controller.add(dados);
                  });
}
  
  //Metodo para obter a id do usuario logado
  Future recuperarIdUserLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var userLogado = auth.currentUser;
    _idUserLogado = userLogado?.uid;

    _addListnerConversa();

  }
  

  @override
  void initState() {
    super.initState();
    recuperarIdUserLogado();
  }
  
  /*
   Este metodo fecha o um determinado evento depois de não precisar mais o mesmo e dessa forma poupando recursos
*/
@override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    /*
    Fazendo o Stream desta forma somente iremos add o evento uma única vez e caso os dados 
    mudém iremos receber esses dados sem necessáriamente carregar novamente.
    */
    stream: _controller.stream,
    builder: (context, snapshot){
      switch(snapshot.connectionState){
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 16, bottom: 8),
                child: CircularProgressIndicator(color: Colors.green,),
               ),
                 Text("Carregando conversas...")
              ],
              )
          );
        case ConnectionState.active:
        case ConnectionState.done:

        QuerySnapshot querySnapshot = snapshot.requireData;

         if(snapshot.hasError){
           return Text("Erro ao carregar conversas!");
         }
         else{
            if(querySnapshot.docs.length == 0){
              return Center(
                child: Text("Não tém nemhuma conversa!!!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                );
            }
            else{
              return ListView.builder(
                        itemCount:querySnapshot.docs.length,
                        itemBuilder: (context, index){
                          
                          List<DocumentSnapshot> conversa = querySnapshot.docs.toList();
                          DocumentSnapshot item = conversa[index];

                          String urlImagem = item["caminhoFoto"];
                          String nome      = item["nome"];
                          String mensagem  = item["mensagem"];
                          String tipo      = item["tipoMensagem"];
                          String idUserMarcado      = item["idDestinatario"];

                          Usuario usuario = Usuario();
                          usuario.setNome      = nome;
                          usuario.setUrlImagem = urlImagem;
                          usuario.setIdUsuario = idUserMarcado;

                          return ListTile(
                            
                            onTap: (){
                              Navigator.pushNamed(
                                context, 
                                RouteGenerator.ROUTE_MENSAGEM, 
                                arguments: usuario);
                            },

                            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            leading: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage: urlImagem != null
                                  ?NetworkImage( urlImagem )
                                  : null
                            ),
                            title: Text( nome,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            subtitle: Text(tipo == "texto"
                                        ? mensagem
                                        : "Imagem...",
                              style:TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ), 
                            ),
                          );
                         } 
                      );
            }
         }
      }

    }
    );
     
  }
}


