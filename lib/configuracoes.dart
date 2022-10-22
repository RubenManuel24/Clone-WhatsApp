import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  TextEditingController  _controllerNome = TextEditingController();
  var _imagem;

 Future _atualizarImagem(String escolhaOpcao) async {
    var _imagemSelecionada;
    switch(escolhaOpcao){
      case "Câmera":
        _imagemSelecionada = ImagePicker.platform.pickImage(source: ImageSource.camera);
      break;
      case "Galeria":
        _imagemSelecionada = ImagePicker.platform.pickImage(source: ImageSource.gallery);
      break;
    }

    setState((){
      _imagem = _imagemSelecionada;
    });
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
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2F1665922194090%5B1%5D.jpg?alt=media&token=a2bbdbeb-259c-42d1-88c2-802256c5afa6"),
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
                  onPressed: (){}, 
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