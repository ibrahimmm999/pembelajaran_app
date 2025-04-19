import 'package:equatable/equatable.dart';

class QuizModel extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;
  final int numberOfQuestion;

  const QuizModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.numberOfQuestion,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['created_at'],
      numberOfQuestion: json['number_of_questions'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        numberOfQuestion,
      ];
}
