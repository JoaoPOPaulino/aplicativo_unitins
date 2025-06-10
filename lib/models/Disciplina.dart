class Disciplina {
  final int id;
  final String curso;
  final int periodo;
  final String disciplina;
  final int cargaHoraria;
  final List<int>? preRequisitos;

  Disciplina({
    required this.id,
    required this.curso,
    required this.periodo,
    required this.disciplina,
    required this.cargaHoraria,
    this.preRequisitos,
  });

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: int.parse(json['id']?.toString() ?? '0'),
      curso: json['curso']?.toString() ?? '',
      periodo: int.parse(json['periodo']?.toString() ?? '0'),
      disciplina: json['disciplina']?.toString() ?? '',
      cargaHoraria: int.parse(json['cargaHoraria']?.toString() ?? '0'),
      preRequisitos: (json['preRequisitos'] as List<dynamic>?)?.cast<int>(),
    );
  }
}