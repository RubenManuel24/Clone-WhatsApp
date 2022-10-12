import 'package:flutter/material.dart';
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  
  String _messagemErro = "";

  _validarCadastro(){
    if(controllerNome.text.isNotEmpty){
       if(controllerNome.text.length > 4){
        if(controllerEmail.text.isNotEmpty){
          if(controllerEmail.text.contains("@")){
             if(controllerSenha.text.isNotEmpty){
                if(controllerSenha.text.length >= 6){
                  setState(() {
                      _messagemErro = "Sucesso!";
                  });
                }
                else{
                     setState(() {
                       _messagemErro = "A Senha tem que ter mais de 5 digitos";
                     });
               }
             } 
             else{
                  setState(() {
                    _messagemErro = "Preencha a Senha";
                 });
            }

          }
          else{
               setState(() {
                 _messagemErro = "O E-mail tem que conter @";
              });
         }

        } 
        else{
         setState(() {
             _messagemErro = "Preencha o E-mail";
         });
       }

       }
       else{
             setState(() {
               _messagemErro = "O Nome tem que ter mais de 4 digitos";
             });
    }

    }
    else{
         setState(() {
             _messagemErro = "Preencha o Nome";
         }); 
    }
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
                  controller: controllerNome,
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
                  controller: controllerEmail,
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
                  controller: controllerSenha,
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
                  child: Text(_messagemErro, 
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
