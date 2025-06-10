class Boletim {
  final int id;
  final int userId;
  final int disciplinaId;
  final String disciplina;
  final int periodo;
  final double nota;
  final String frequencia;
  final String status;
  final String? semestreConclusao;

  Boletim({
    required this.id,
    required this.userId,
    required this.disciplinaId,
    required this.disciplina,
    required this.periodo,
    required this.nota,
    required this.frequencia,
    required this.status,
    this.semestreConclusao,
  });

  factory Boletim.fromJson(Map<String, dynamic> json, String disciplinaNome, int periodo) {
    try {
      return Boletim(
        id: int.parse(json['id']?.toString() ?? '0'),
        userId: int.parse(json['userId']?.toString() ?? '0'),
        disciplinaId: int.parse(json['disciplinaId']?.toString() ?? '0'),
        disciplina: disciplinaNome,
        periodo: periodo,
        nota: double.tryParse(json['nota']?.toString() ?? '0') ?? 0,
        frequencia: json['frequencia']?.toString() ?? '0%',
        status: json['status']?.toString() ?? 'Status não informado',
        semestreConclusao: json['semestreConclusao']?.toString(),
      );
    } catch (e) {
      print('Erro ao parsear boletim: $e\nDados: $json');
      rethrow;
    }
  }
}