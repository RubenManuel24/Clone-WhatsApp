import 'package:cloud_firestore/cloud_firestore.dart';

class Conversa {
  
  var _idRemetente;
  var _idDestinatario;
  var _nome;
  var _mensagem;
  var _caminhoFoto;
  var _tipoMensagem;

  Conversa();


  Future salvarDadosFirebaseFirestore() async {
    /*
    
    + conversa
      + Ruben Manuel
        + ultima_conversa
          + Bruno Mars
             nome
             mensagem
             ...
    
    */
   FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("conversa")
          .doc(this._idRemetente)
          .collection("ultima_conversa")
          .doc(this._idDestinatario)
          .set(this.toMap());

  }

  //Metodo para transformar um objeto em Map<>
  Map<String, dynamic> toMap(){
    
        Map<String, dynamic> map = {
            "idRemetente"    : this._idRemetente,
            "idDestinatario" : this._idDestinatario ,
            "nome"           : this._nome,
            "mensagem"       : this._mensagem,
            "caminhoFoto"    : this._caminhoFoto,
            "tipoMensagem"   : this._tipoMensagem
       };

       return map;
  }

  String get getIdRemetente => this._idRemetente;

  set setIdRemetente(String idRemetente){
    this._idRemetente = idRemetente;
  }

  String get getIdestinario => this._idDestinatario;

  set setIdestinario(String idestinario){
    this._idDestinatario = idestinario;
  }

  get getTipoMensagem => this._nome;

  set setTipoMensagem(String tipoMensagem){
    this._tipoMensagem = tipoMensagem;
  }

  get getNome => this._nome;

  set setNome(String nome){
    this._nome = nome;
  }

  get getMensagem => this._mensagem;

  set setMensagem(String mensagem){
    this._mensagem = mensagem;
  }

  get getCaminhoFoto => this._caminhoFoto;

  set setCaminhoFoto(String caminhoFoto){
    this._caminhoFoto = caminhoFoto;
  }

}
