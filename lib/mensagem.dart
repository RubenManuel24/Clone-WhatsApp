import 'package:flutter/material.dart';

class Mensagem extends StatefulWidget {

var argumentoCapturado;

  Mensagem(this.argumentoCapturado);

  
  @override
  State<Mensagem> createState() => _MensagemState();
}

class _MensagemState extends State<Mensagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Text(widget.argumentoCapturado),
      ),
      body: Container(),
    );
  }
}
