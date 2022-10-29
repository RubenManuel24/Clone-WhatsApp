import 'package:app_clone_whatsapp/model/mensagem_model.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Mensagem extends StatefulWidget {

Usuario contato;

  Mensagem(this.contato);

  
  @override
  State<Mensagem> createState() => _MensagemState();
}

class _MensagemState extends State<Mensagem> {

  TextEditingController _controllerMensagem = TextEditingController();
   FirebaseFirestore db =  FirebaseFirestore.instance;
   var _idUserLogado;
   var _idUserDestinatario;

  _enviarMensagem(){
    
    String textoMensagem = _controllerMensagem.text;
    if(textoMensagem.isNotEmpty){
       MensagemModel mensagemModel = MensagemModel();
    mensagemModel.setIdUsuarioAtual = _idUserLogado;
    mensagemModel.setIdUsuarioDestinario = _idUserDestinatario;
    mensagemModel.setMensagemModel = textoMensagem;
    mensagemModel.setUrlImagem = "";
    mensagemModel.setTipo = "texto";
     
     //Salvar mensagem para remetente
     _salvarMensagens(_idUserLogado, _idUserDestinatario, mensagemModel);

     //Salvar mensagem para destinatario
     _salvarMensagens(_idUserDestinatario, _idUserLogado, mensagemModel);

    }
    
  }

//Metodo para salvar mensagem no FirebaseFirestore (BD)
 Future _salvarMensagens(String idLogado, String idDestinatario, MensagemModel smg ) async {

   await db.collection("mensagem")
  .doc(idLogado)
  .collection(idDestinatario)
  .add(smg.toMap());

  _controllerMensagem.clear();
   /*
        + mensagemModel
          + Ruben Manuel
            + Neymar Jr
              + identificadorFirebase
                <Mensagem>
    */

  }
    
  _enviarImagem(){
   print("Enviar Imagem...");
  }

      //Metodo para recuperar a url do Usuario corrente
      Future _recuperaUrlUser() async {
        FirebaseAuth auth = FirebaseAuth.instance;
        var userLogado = auth.currentUser;
        _idUserLogado = userLogado?.uid;
        _idUserDestinatario = widget.contato.getIdUsuario;

      }

       
       @override
       void initState() {
         super.initState();
         _recuperaUrlUser();
       }

  @override
  Widget build(BuildContext context) {

 var caixaMensagem = Container(
  padding: EdgeInsets.all(8),
  child: Row(
      children: [
       Expanded(
        child:  Padding(
          padding: EdgeInsets.only(right: 8),
          child: TextField(
            controller: _controllerMensagem,
            keyboardType: TextInputType.text,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Digite mensagem",
              hintStyle: TextStyle(fontSize: 15),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32)
              ),
              contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
              prefixIcon: IconButton(
                onPressed: _enviarImagem, 
                icon: Icon(Icons.camera_alt, color:Color(0xff075E54))
            ),

          ),
        )
        )
       ),
       FloatingActionButton(
        backgroundColor: Color(0xff075E54),
        onPressed: _enviarMensagem,
        child: Icon(Icons.send, color: Colors.white),
        mini: true,
        )
      ],
    )
  ); 

   var stream = StreamBuilder<QuerySnapshot>(
    stream: db.collection("mensagem")
          .doc(_idUserLogado)
          .collection(_idUserDestinatario)
          .snapshots(),
    builder: (context, snapshot){
      switch(snapshot.connectionState){
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Expanded(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                     child: CircularProgressIndicator(color: Colors.green ), 
                    ),
                    Text("Carregando mensagens...")
                ]
                ),
            ) );
        case ConnectionState.active:
        case ConnectionState.done:

        QuerySnapshot querySnapshot = snapshot.requireData;

        if(snapshot.hasError){
          return Expanded(
            child: Text("Erro ao carregar mensagens!")
          );
        }
        else{
          return Expanded(child:
            ListView.builder(
      itemCount: querySnapshot.docs.length,
       itemBuilder: (context, indice){
           
        //Corrento dos na lista
        List<QueryDocumentSnapshot> mensagem = querySnapshot.docs;

        DocumentSnapshot item = mensagem[indice];

         double larguraContainer = MediaQuery.of(context).size.width * 0.8;
         //larguraContainer -> 100
         //x                -> 80


        //Definir a color e aliamento das mensagem
         var colorMensagem = Color(0xffd2ffa5);
         var aliamentoMensagem = Alignment.centerRight;

         if(_idUserLogado != item["idUsuario"]){
           colorMensagem = Colors.white;
           aliamentoMensagem = Alignment.centerLeft;
         }

       return Align(
            alignment: aliamentoMensagem,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: larguraContainer,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: colorMensagem,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(item["mensagem"],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ),
          );

       },
       
        )
          );
        }

      }

    });
  

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: widget.contato.getUrlImagem != null
                ? NetworkImage(widget.contato.getUrlImagem)
                :null
            ),
            Padding(padding: EdgeInsets.only(left:8),
            child: Text(widget.contato.getNome),
            )
          ],
          )
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/imagemwhat.png"),
            fit: BoxFit.cover
          ),
          
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                stream,
                caixaMensagem
              ],
            ),
          )),
      ),
    );
  }
}
