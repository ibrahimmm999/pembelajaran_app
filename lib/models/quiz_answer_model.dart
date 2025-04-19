import 'package:equatable/equatable.dart';

class QuizAnswerModel extends Equatable {
  final int id;
  final int quizId;
  final DateTime createdAt;
  final int quizQuestionId;
  final String answer;
  final bool isCorrect;

  const QuizAnswerModel({
    required this.id,
    required this.quizQuestionId,
    required this.createdAt,
    required this.answer,
    required this.quizId,
    required this.isCorrect,
  });

  factory QuizAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuizAnswerModel(
      id: json['id'],
      quizQuestionId: json['quiz_question_id'],
      createdAt: json['created_at'],
      answer: json['answer'],
      quizId: json['quiz_id'],
      isCorrect: json['is_correct'],
    );
  }

  @override
  List<Object?> get props =>
      [id, quizQuestionId, createdAt, answer, quizId, isCorrect];
}
