
import 'package:firebase_auth/firebase_auth.dart';
import 'package:partirecept/constants/authStrings.dart';
import 'package:partirecept/screens/authenticaiton/authModel.dart';
import 'package:partirecept/services/authService.dart';

class AuthViewModel{
  final AuthModel _authModel = AuthModel();
  final AuthService _authService;

  AuthViewModel(this._authService);

  onEmailChange(String? email) {
    _authModel.email = email;
  }

  onPasswordChange(String? password) {
    _authModel.password = password;
  }

  onNameChange(String? name) {
    _authModel.fullName = name;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AuthStrings.emptyNameErrorMsg;
    }
    return null;
  }

  /**
   *  ^ matches the starting of the sentence.
      [a-zA-Z0-9+_.-] matches one character from the English alphabet (both cases), digits, “+”, “_”, “.” and, “-” before the @ symbol.
      \+ indicates the repetition of the above-mentioned set of characters one or more times.
      @ matches itself.
      [a-zA-Z0-9.-] matches one character from the English alphabet (both cases), digits, “.” and “–” after the @ symbol.
      $ indicates the end of the sentence.
   */
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AuthStrings.emptyEmailErrorMsg;
    }

    RegExp regExp = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$',
        caseSensitive: false, multiLine: false);
    if (!regExp.hasMatch(value)) {
      return AuthStrings.invalidEmailErrorMsg;
    }
    return null;
  }

  /**
   * Password can not be null or empty
   * Password must be minimum eight characters, one letter and one number
   */
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AuthStrings.emptyPasswordErrorMsg;
    }
    // Minimum eight characters, at least one letter and one number
    RegExp regExp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
        multiLine: false, caseSensitive: true);
    if (!regExp.hasMatch(value)) {
      return AuthStrings.invalidPasswordErrorMsg;
    }
    return null;
  }

  /**
   * Password can not be null or empty
   */
  String? passwordLoginValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AuthStrings.emptyPasswordErrorMsg;
    }
    return null;
  }

  /**
   * Confirmation password must match password
   */
  String? passwordConfirmationValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AuthStrings.emptyConfirmationPasswordErrorMsg;
    }
    if (_authModel.password != value) {
      return AuthStrings.passwordDoesNotMatchErrorMsg;
    }
    return null;
  }

  Future<User?> createAccount() async {
    User? user = await _authService.createAccount(_authModel.email, _authModel.password, _authModel.fullName);
    return user;
  }

  Future<User?> login() async {
    User? user = await _authService.signInWithEmailAndPassword(_authModel.email, _authModel.password);
    return user;
  }
}
