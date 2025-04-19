import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  bool isGuru = false;

  UserProvider() {
    _loadUserState();
  }

  // Load state from SharedPreferences
  Future<void> _loadUserState() async {
    final prefs = await SharedPreferences.getInstance();
    isGuru = prefs.getBool('isGuru') ?? false;
    notifyListeners();
  }

  void setIsGuru(bool statusLogin) async {
    isGuru = statusLogin;

    // Save to SharedPreferences whenever state changes
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGuru', statusLogin);

    notifyListeners();
  }
}
