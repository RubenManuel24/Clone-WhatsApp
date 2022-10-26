import 'dart:ui';

import 'package:flutter/material.dart';

class Mensagem extends StatefulWidget {

var argumentoCapturado;

  Mensagem(this.argumentoCapturado);

  
  @override
  State<Mensagem> createState() => _MensagemState();
}

class _MensagemState extends State<Mensagem> {

   List<String> listaMensagem = [
     "Olá meu amigo, tudo bem?",
     "Tudo ótimo!!! e contigo?",
     "Estou muito bem!! queria ver uma coisa contigo, você vai na corrida de moto?",
     "Não sei ainda :(",
     "porque se você fosse, queria ver se posso ir com você...",
     "Posso te confirma no sábado? vou ver isso",
     "Opa! tranquilo",
     "Excelente!!",
     "Estou animado para essa corrida, não vejo a hora de chegar!",
     "Vai estar bem legal!! terá muita gente",
     "vai sim!",
     "Lembra do carro que tinha te falado",
     "Que legal!!"
  ]; 

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
    
    var listView = Expanded(
      child: ListView.builder(
      itemCount: listaMensagem.length,
       itemBuilder: (context, indice){

         double larguraContainer = MediaQuery.of(context).size.width * 0.8;
         //larguraContainer -> 100
         //x                -> 80



        //Definir a color e aliamento das mensagem
         var colorMensagem = Color(0xffd2ffa5);
         var aliamentoMensagem = Alignment.centerRight;

         if(indice % 2 == 0){
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
                child: Text(listaMensagem[indice],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ),
          );

       },
       
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
                listView,
                caixaMensagem
              ],
            ),
          )),
      ),
    );
  }
}
