import 'package:app_clone_whatsapp/model/conversa.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:flutter/material.dart';
class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {

    List<Conversa> _listaConversa = [];
    
 
 
      
@override
  void initState() {
    super.initState();

    Conversa conversaText = Conversa();
    conversaText.setNome = "Messi";
    conversaText.setMensagem = "Meu sobrinho nunca mais!!!";
    conversaText.setCaminhoFoto = "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fdescarregar%20(3).jpg?alt=media&token=043de23b-beab-403e-9319-4f69de4a0834";
    _listaConversa.add(conversaText);
    
  }


 
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: _listaConversa.length,
      itemBuilder: (context, index){

         Conversa conversa = _listaConversa[index];

         return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.getCaminhoFoto),
          ),
          title: Text(conversa.getNome,
           style: TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),
          ),
          subtitle: Text(conversa.getMensagem,
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
