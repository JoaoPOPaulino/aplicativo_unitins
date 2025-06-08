class Disciplina {
  final int id;
  final String curso;
  final int periodo;
  final String disciplina;
  final int cargaHoraria;

  Disciplina({
    required this.id,
    required this.curso,
    required this.periodo,
    required this.disciplina,
    required this.cargaHoraria,
  });

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: int.parse(json['id'].toString()),
      curso: json['curso']?.toString() ?? '',
      periodo: int.parse(json['periodo'].toString()),
      disciplina: json['disciplina']?.toString() ?? '',
      cargaHoraria: int.parse(json['cargaHoraria'].toString()),
    );
  }
}