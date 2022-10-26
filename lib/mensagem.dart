import 'dart:ui';

import 'package:flutter/material.dart';

class Mensagem extends StatefulWidget {

var argumentoCapturado;

  Mensagem(this.argumentoCapturado);

  
  @override
  State<Mensagem> createState() => _MensagemState();
}

class _MensagemState extends State<Mensagem> {

  TextEditingController _controllerMensagem = TextEditingController();

  _enviarMensagem(){
    print("Enviar mensagem...");
    
  }

  _enviarImagem(){
   print("Enviar Imagem...");
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


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Text(widget.argumentoCapturado),
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
                Text("ListViews"),
                caixaMensagem
              ],
            ),
          )),
      ),
    );
  }
}
