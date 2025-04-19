import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  bool isGuru = false;

  void setIsGuru(bool statusLogin) {
    isGuru = statusLogin;
    notifyListeners();
  }
}
