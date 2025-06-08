class Boletim {
  final int id;
  final int userId;
  final String disciplina;
  final double nota;
  final String frequencia;
  final String status;

  Boletim({
    required this.id,
    required this.userId,
    required this.disciplina,
    required this.nota,
    required this.frequencia,
    required this.status,
  });

  factory Boletim.fromJson(Map<String, dynamic> json) {
    try {
      return Boletim(
        id: int.parse(json['id']?.toString() ?? '0'),
        userId: int.parse(json['userId']?.toString() ?? '0'),
        disciplina: json['disciplina']?.toString() ??
            json['disciplinaId']?.toString() ??
            'Disciplina não informada',
        nota: double.tryParse(json['nota']?.toString() ?? '0') ?? 0,
        frequencia: json['frequencia']?.toString() ?? '0%',
        status: json['status']?.toString() ?? 'Status não informado',
      );
    } catch (e) {
      print('Erro ao parsear boletim: $e\nDados: $json');
      rethrow;
    }
  }
}