import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController _controllerNome = TextEditingController();
  var _imagem;
  var _controlProgres = false;
  var _urlImagemRecuperada;
  var _urlUserLogado;
  
 Future _atualizarImagem(String escolhaOpcao) async {
    var _imagemSelecionada;
    switch(escolhaOpcao){
      case "Câmera":
        _imagemSelecionada = await ImagePicker.platform.getImage(source: ImageSource.camera);
        
      break;
      case "Galeria":
        _imagemSelecionada = await ImagePicker.platform.getImage(source: ImageSource.gallery);
       
      break;
    }

    setState((){
      _imagem = _imagemSelecionada;
      if(_imagem != null){
        _controlProgres = true;
        _uploadImagem();
      }
    });
  }

//metodo para fazer upload da imagem para FireBase
  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var pastaRaiz = storage.ref();
    var arquivo = await pastaRaiz
    .child("ImagemPefil")
    .child("$_urlUserLogado.jpg");

//Upload da Imagem
    var task = arquivo.putFile(File(_imagem.path));

//Controlando o progresso da imagem
    task.snapshotEvents.listen((TaskSnapshot taskSnapshot)  { 
        if(taskSnapshot.state == TaskState.running){
          setState((){
            _controlProgres = true;
          });
        }
        else if(taskSnapshot.state == TaskState.success){
             setState((){
            _controlProgres = false;
          });
        }

    });

  //Pegado a url da imagem
  String url = await (await task).ref.getDownloadURL();
   _atualizarImagemFirestore(url);
   setState(() {
     _urlImagemRecuperada = url;
   });

  }

//Metodo atualizar imagem no Firestore
_atualizarImagemFirestore(String url){

  Map<String, dynamic> dadoAtualizar = {
    "urlImagem" : url
  };

 FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection("Usuario")
  .doc(_urlUserLogado)
  .update(dadoAtualizar);
}

//Metodo atualizar o nome no Firestore
_atualizarNomeFirestore(){

var nome = _controllerNome.text;
FirebaseFirestore db = FirebaseFirestore.instance;

  Map<String, dynamic>  dadoAtualizar = {
    "nome" : nome
  };

  db.collection("Usuario")
  .doc(_urlUserLogado)
  .update(dadoAtualizar);
}


//Metodo para recuperar a url do Usuario corrente
Future _recuperaUrlUser() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var userLogado = await auth.currentUser;
  _urlUserLogado = userLogado?.uid;

FirebaseFirestore db = FirebaseFirestore.instance;
var snapshot = await db.collection("Usuario")
.doc(_urlUserLogado) 
.get();

Map<String, dynamic>? dados = snapshot.data();
 _controllerNome.text = dados!["nome"];

if(dados["urlImagem"] != null){
  setState(() {
     _urlImagemRecuperada = dados["urlImagem"];
  });
 
}

}

  @override
  void initState() {
    super.initState();
    _recuperaUrlUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Text("Configurações"),
      ),
      body: Container(
        child: Padding(padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
               Container(
                padding: EdgeInsets.all(15),
                child: _controlProgres 
                  ? CircularProgressIndicator(color: Colors.green,)
                  :Container(),
               ),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: 
                  _urlImagemRecuperada != null 
                    ?  NetworkImage(_urlImagemRecuperada)
                    :null
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                         _atualizarImagem("Câmera");
                      }, 
                      child: Text("Câmera", style: TextStyle(color: Colors.black),)),
                     TextButton(
                      onPressed: (){
                        _atualizarImagem("Galeria");
                      }, 
                      child: Text("Galeria", style: TextStyle(color: Colors.black),))
                  ],
                ),
                TextField(
                  controller: _controllerNome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Nome",
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),

                ),
                Padding(padding: EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: (){
                    _atualizarNomeFirestore();
                  }, 
                  child: Text("Salvar",
                  style: TextStyle(color: Colors.white, fontSize: 20),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                      )
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.fromLTRB(32, 16, 32, 16)
                    )
                  ),
                  ),
                )
              ]
              ),
          ),
        ),
        ),
      ),
    );
  }
}