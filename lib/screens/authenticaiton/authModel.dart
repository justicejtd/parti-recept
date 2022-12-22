import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  String _email = '';
  String _password = "";
  String _fullName = '';

  String get email => _email;

  set email(String? value) {
    _email = value ?? "";
  }

  String get password => _password;

  set password(String? value) {
    _password = value ?? "";
  }

  String get fullName => _fullName;

  set fullName(String? value) {
    _fullName = value ?? "";
  }
}
