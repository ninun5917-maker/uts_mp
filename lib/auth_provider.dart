import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  bool _isLoggedIn = false;

  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  //fungsi Login Nya
  void login(String email) {
    _email = email;
    _isLoggedIn = true;
    notifyListeners();
  }

  //fungsi Logout Nya
  void logout() {
    _email = "";
    _isLoggedIn = false;
    notifyListeners();
  }
}
