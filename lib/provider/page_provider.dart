import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier {
  int page = 0;

  void setPage(int newPage) {
    page = newPage;
    notifyListeners();
  }
}
