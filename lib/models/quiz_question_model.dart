import 'package:equatable/equatable.dart';

class QuizQuestionModel extends Equatable {
  final int id;
  final int quizId;
  final DateTime createdAt;
  final String number;
  final String question;

  const QuizQuestionModel({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.question,
    required this.quizId,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id'],
      number: json['quiz_question_id'],
      createdAt: json['created_at'],
      question: json['question'],
      quizId: json['quiz_id'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        number,
        createdAt,
        question,
        quizId,
      ];
}
