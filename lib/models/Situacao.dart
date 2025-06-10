class Situacao {
  final int id;
  final int userId;
  final String matriculaStatus;
  final List<String> documentosPendentes;
  final String pendenciasFinanceiras;
  final String pendenciasAcademicas;
  final String ultimaAtualizacao;
  final int periodoAtual;

  Situacao({
    required this.id,
    required this.userId,
    required this.matriculaStatus,
    required this.documentosPendentes,
    required this.pendenciasFinanceiras,
    required this.pendenciasAcademicas,
    required this.ultimaAtualizacao,
    required this.periodoAtual,
  });

  factory Situacao.fromJson(Map<String, dynamic> json) {
    return Situacao(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['userId'].toString()),
      matriculaStatus: json['matriculaStatus']?.toString() ?? '',
      documentosPendentes: (json['documentosPendentes'] as List<dynamic>?)?.cast<String>() ?? [],
      pendenciasFinanceiras: json['pendenciasFinanceiras']?.toString() ?? '',
      pendenciasAcademicas: json['pendenciasAcademicas']?.toString() ?? '',
      ultimaAtualizacao: json['ultimaAtualizacao']?.toString() ?? '',
      periodoAtual: int.parse(json['periodoAtual'].toString()),
    );
  }
}