class MensagemModel {

  var _idUsuarioDestinario;
  var _idUsuarioAtual;
  var _mensagem;
  var _urlImagem;

  ///Define o tipo da mensagem, que pode ser "texto" ou "imagem"
  var _tipo;

  MensagemModel();

Map<String, dynamic> toMap() {

  Map<String, dynamic> map = {
    
    "idUsuario" : this._idUsuarioAtual,
    "mensagem" : this._mensagem,
    "urlImagem" : this._urlImagem,
    "tipo" : this._tipo

  };

  return map;

}


  String get getIdUsuarioDestinario => this._idUsuarioDestinario;

  set setIdUsuarioDestinario(String idUsuarioDestinario){
    this._idUsuarioDestinario = idUsuarioDestinario;
  }

  String get getIdUsuarioAtual => this.getIdUsuarioAtual;
  
  set setIdUsuarioAtual(String idUsuarioAtual){
    this._idUsuarioAtual = idUsuarioAtual;
  }

  String get getMensagemModel => this._mensagem;

  set setMensagemModel(String mensagem){
    this._mensagem = mensagem;
  }

  String get getUrlImagem => this._urlImagem;

  set setUrlImagem(String urlImagem){
    this._urlImagem = urlImagem;
  }

  String get getTipo => this._tipo;

  set setTipo(String tipo){
    this._tipo = tipo;
  }


}
