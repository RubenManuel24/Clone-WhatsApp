class Conversa {

  String? _nome;
  String? _mensagem;
  String? _caminhoFoto;

  Conversa(this._nome, this._mensagem, this._caminhoFoto);

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
