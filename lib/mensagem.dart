import 'package:app_clone_whatsapp/model/conversa.dart';
import 'package:app_clone_whatsapp/model/mensagem_model.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
   var _controlProgresImagem = false;

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

     _salvarConversa(mensagemModel);

    }
    
  }

  _salvarConversa(MensagemModel msg){

     //Conversa que irá para Remetente
     Conversa cRemetente = Conversa();
     cRemetente.setIdRemetente = _idUserLogado;
     cRemetente.setIdestinario = _idUserDestinatario;
     cRemetente.setMensagem = msg.getMensagemModel;
     cRemetente.setNome = widget.contato.getNome;
     cRemetente.setCaminhoFoto = widget.contato.getUrlImagem;
     cRemetente.setTipoMensagem = "texto";
     cRemetente.salvarDadosFirebaseFirestore();

     //Conversa que irá para Destinatario
     Conversa cDestinatario = Conversa();
     cDestinatario.setIdRemetente = _idUserDestinatario;
     cDestinatario.setIdestinario = _idUserLogado;
     cDestinatario.setMensagem = msg.getMensagemModel;
     cDestinatario.setNome = widget.contato.getNome;
     cDestinatario.setCaminhoFoto = widget.contato.getUrlImagem;
     cDestinatario.setTipoMensagem = "texto";
     cDestinatario.salvarDadosFirebaseFirestore();

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


  
    
  _enviarImagem() async {
    var _imagemSelecionada;
    _imagemSelecionada = await ImagePicker.platform.getImage(source: ImageSource.gallery);
  

  //código para obter códigos que serão id das iamgem
  var idImagemCodigo = DateTime.now().millisecondsSinceEpoch.toString();

  //código para guardar as nebsagens no Firebae_storage
     FirebaseStorage storage = FirebaseStorage.instance;
    var pastaRaiz = storage.ref();
    var arquivo = await pastaRaiz
    .child("mensageImagem")
    .child(_idUserLogado)
    .child( idImagemCodigo +".jpg");

//Upload da Imagem
    var task = arquivo.putFile(File(_imagemSelecionada.path));

//Controlando o progresso da imagem
    task.snapshotEvents.listen((TaskSnapshot taskSnapshot)  { 
        if(taskSnapshot.state == TaskState.running){
          setState((){
            _controlProgresImagem = true;
          });
        }
        else if(taskSnapshot.state == TaskState.success){
             setState((){
            _controlProgresImagem = false;
          });
        }

    });

  //Pegado a url da imagem
  String url = await (await task).ref.getDownloadURL();

   MensagemModel mensagemModel = MensagemModel();
    mensagemModel.setIdUsuarioAtual = _idUserLogado;
    mensagemModel.setIdUsuarioDestinario = _idUserDestinatario;
    mensagemModel.setMensagemModel = "";
    mensagemModel.setUrlImagem = url;
    mensagemModel.setTipo = "imagem";

    //Salvar mensagem para remetente
     _salvarMensagens(_idUserLogado, _idUserDestinatario, mensagemModel);

     //Salvar mensagem para destinatario
     _salvarMensagens(_idUserDestinatario, _idUserLogado, mensagemModel);

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
              prefixIcon: _controlProgresImagem == true 
                     ? CircularProgressIndicator(color: Colors.green,)
                     :IconButton( icon: Icon(Icons.camera_alt, color:Color(0xff075E54)),
                onPressed: _enviarImagem, 
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
          return  Text("Erro ao carregar mensagens!");
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
                child: item["tipo"]  == "texto" 
                  ?Text(item["mensagem"], style: TextStyle(fontSize: 18))
                  : Image.network(item["urlImagem"] )
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
