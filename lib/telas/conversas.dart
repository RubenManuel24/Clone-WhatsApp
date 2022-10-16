import 'package:app_clone_whatsapp/model/conversa.dart';
import 'package:app_clone_whatsapp/model/usuario.dart';
import 'package:flutter/material.dart';
class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {

    List<Conversa> _listaConversa = [
    
          Conversa(
            "Rosa", 
            "Estou grávida, mas o filho não é seu.", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Flinda.jpg?alt=media&token=c9e65336-763d-4a4b-a5d6-e868cc283e99"),
          Conversa(
            "ACJ", 
            "Meu jovem serenidade!", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP.jpg?alt=media&token=a25040db-90fd-483f-a282-ffecdd970232"),
          Conversa(
            "Mbappé", 
            "Foi despedir o presidente do PSG o que achas?", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fdescarregar.jpg?alt=media&token=4fdd6583-95f6-4221-9874-906840bc5ed5"),
        Conversa(
            "JLO", 
            "Meu caro jovem localização?", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(1).jpg?alt=media&token=b9418ab9-cb35-4f1e-98ec-c40987cd1d44"),
        Conversa(
            "Neymar", 
            "Esse mundial é do Brazil meu moleque", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(2).jpg?alt=media&token=0b75a228-eda0-4d54-bca0-67aa806178d3"),
        Conversa(
            "Mandela",
            "Como é que África está?", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(3).jpg?alt=media&token=7e68cae5-c912-47b8-8f45-2cf0f424f2b1"),
      Conversa(
            "Donald Tump", 
            "Aqui tem birraaaaaa!!!!", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fdescarregar%20(1).jpg?alt=media&token=b026036b-e3a3-44be-ac7f-bf247c1fb55b"),
      Conversa(
            "Bill Gates", 
            "Queres quanto na tua conta?", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(4).jpg?alt=media&token=84b901aa-fac4-4b6c-80be-ef4162cd8496"),
      Conversa(
            "Ary Papel", 
            "Essa bola de Ouro é minha!!!", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(5).jpg?alt=media&token=5d1d938a-871f-454e-adb1-6b3782e81585"),
      Conversa(
            "Príncipe Ouro Negro", 
            "Ai minha vuaida", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fdescarregar%20(2).jpg?alt=media&token=5e3a7eb3-0dd6-432d-a404-5b3dc22264c4"),
      Conversa(
            "Bolsonaro", 
            "Eu vou vencer as eleições.", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(6).jpg?alt=media&token=14d0b5ac-8f2e-4f4a-b670-40a9ebc5d550"),
      Conversa(
            "Lulas", 
            "Renascí das cinzas ", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2FOIP%20(7).jpg?alt=media&token=c78fc507-b87f-4e4e-b069-13ed82a902f0"),
      Conversa(
            "Messi", 
            "Meu sobrinho nunca mais!!!", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fdescarregar%20(3).jpg?alt=media&token=043de23b-beab-403e-9319-4f69de4a0834"),
      Conversa(
            "CR7", 
            "Meu Puto aqui no Man United está rijo!", 
            "https://firebasestorage.googleapis.com/v0/b/whatsapp-73d7d.appspot.com/o/ImagemPefil%2Fth.jpg?alt=media&token=a7e11ed9-e182-4bc4-9667-08b932947dc0")

  ];
        


 
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
