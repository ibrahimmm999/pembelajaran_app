import 'package:equatable/equatable.dart';

class MaterialModel extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;
  final String url;

  const MaterialModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.url,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['created_at'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        url,
      ];
}
