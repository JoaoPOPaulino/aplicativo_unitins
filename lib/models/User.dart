class User {
  final int id;
  final String nome;
  final String email;
  final String senha;

  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id'].toString()),
      nome: json['nome']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      senha: json['senha']?.toString() ?? '',
    );
  }
}