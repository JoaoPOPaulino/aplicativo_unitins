class User {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final int? periodoAtual;
  final String? curso;

  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.periodoAtual,
    this.curso,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['id'].toString()),
      nome: json['nome']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      senha: json['senha']?.toString() ?? '',
      periodoAtual: json['periodoAtual'] != null ? int.parse(json['periodoAtual'].toString()) : null,
      curso: json['curso']?.toString(),
    );
  }
}