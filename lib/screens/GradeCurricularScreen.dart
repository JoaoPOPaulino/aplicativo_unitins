import 'package:flutter/material.dart';
import '../models/Disciplina.dart';
import '../services/GradeCurricularService.dart';
import '../widgets/gradeCurricular/CourseSelector.dart';
import '../widgets/gradeCurricular/GradeAppBar.dart';
import '../widgets/gradeCurricular/GradeEmptyState.dart';
import '../widgets/gradeCurricular/GradeErrorState.dart';
import '../widgets/gradeCurricular/GradeInfoDialog.dart';
import '../widgets/gradeCurricular/GradeLoadingState.dart';
import '../widgets/gradeCurricular/GradeSummaryCard.dart';
import '../widgets/gradeCurricular/PeriodoCard.dart';


class GradeCurricularScreen extends StatefulWidget {
  const GradeCurricularScreen({super.key});

  @override
  State<GradeCurricularScreen> createState() => _GradeCurricularScreenState();
}

class _GradeCurricularScreenState extends State<GradeCurricularScreen>
    with SingleTickerProviderStateMixin {
  final GradeCurricularService _service = GradeCurricularService();
  late Future<List<Disciplina>> _gradeFuture;
  String _selectedCurso = 'Sistemas de Informação';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> _cursos = [
    'Sistemas de Informação',
    'Ciência da Computação',
    'Engenharia de Software',
    'Análise e Desenvolvimento de Sistemas',
  ];

  @override
  void initState() {
    super.initState();
    _gradeFuture = _service.fetchGradeCurricular(_selectedCurso);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onCursoChanged(String? value) {
    if (value != null && value != _selectedCurso) {
      setState(() {
        _selectedCurso = value;
        _gradeFuture = _service.fetchGradeCurricular(value);
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  void _showGradeInfo() {
    showDialog(
      context: context,
      builder: (context) => const GradeInfoDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: GradeAppBar(onInfoPressed: _showGradeInfo),
      body: Column(
        children: [
          CourseSelector(
            selectedCurso: _selectedCurso,
            cursos: _cursos,
            onChanged: _onCursoChanged,
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildGradeContent(primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeContent(Color primaryColor) {
    return FutureBuilder<List<Disciplina>>(
      future: _gradeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GradeLoadingState();
        }

        if (snapshot.hasError) {
          return GradeErrorState(
            error: snapshot.error.toString(),
            onRetry: () => setState(() {
              _gradeFuture = _service.fetchGradeCurricular(_selectedCurso);
            }),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const GradeEmptyState();
        }

        return _buildGradeList(snapshot.data!, primaryColor);
      },
    );
  }

  Widget _buildGradeList(List<Disciplina> disciplinas, Color primaryColor) {
    final periodos = disciplinas.map((d) => d.periodo).toSet().toList()..sort();
    final totalCargaHoraria = disciplinas.fold<int>(
      0,
          (sum, disciplina) => sum + disciplina.cargaHoraria,
    );

    return Column(
      children: [
        GradeSummaryCard(
          totalDisciplinas: disciplinas.length,
          totalCargaHoraria: totalCargaHoraria,
          primaryColor: primaryColor,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: periodos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final periodo = periodos[index];
              final disciplinasDoPeriodo = disciplinas
                  .where((d) => d.periodo == periodo)
                  .toList();

              return PeriodoCard(
                periodo: periodo,
                disciplinas: disciplinasDoPeriodo,
                primaryColor: primaryColor,
              );
            },
          ),
        ),
      ],
    );
  }
}