import 'package:flutter/cupertino.dart';

class QuizProvider extends ChangeNotifier {
  int currentNumber = 0;
  String currentUserAnswer = "";
  String currentCorrectAnswer = "";

  void setCurrentNumber(int newcurrentNumber) {
    currentNumber = newcurrentNumber;
    notifyListeners();
  }

  void setCurrentUserAnswer(String newCurrentUserAnswer) {
    currentUserAnswer = newCurrentUserAnswer;
    notifyListeners();
  }

  void setCurrentCorrectAnswer(String newCurrentCorrectAnswer) {
    currentCorrectAnswer = newCurrentCorrectAnswer;
    notifyListeners();
  }
}
