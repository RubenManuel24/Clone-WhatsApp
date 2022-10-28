class Usuario {
  
  var _idUsuario;
  var _nome;
  var _email;
  var _senha; 
  var _urlImagem; 

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
     "nome": this._nome,
     "email": this._email
    };

    return map;

  }

 String get getIdUsuario => this._idUsuario;

 set setIdUsuario(String idUsuario){
  this._idUsuario = idUsuario;
 }

 String get getNome => this._nome;

 set setNome(String nome){
   this._nome = nome;
 }

 String get getEmail => this._email;
 
 set setEmail(String email){
   this._email = email;
 }


 String get getSenha => this._senha;

 set setSenha(String senha){
   this._senha = senha;
 }

 String get getUrlImagem=> this._urlImagem;

 set setUrlImagem(String urlImagem){
   this._urlImagem = urlImagem;
 }

}
