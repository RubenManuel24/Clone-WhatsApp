class Usuario {

  var _nome;
  var _email;
  var _senha; 

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
     "nome": this._nome,
     "email": this._email
    };

    return map;

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


}
