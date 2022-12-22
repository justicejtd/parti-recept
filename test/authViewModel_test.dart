import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:partirecept/constants/authStrings.dart';
import 'package:partirecept/screens/authenticaiton/authViewModel.dart';
import 'package:partirecept/services/authService.dart';

import 'authViewModel_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  var authService = MockAuthService();

  group('nameValidator', () {
    test('should return empty name error message', () {
      // Arrange

      final expectedMsg = AuthStrings.emptyNameErrorMsg;
      String? actualValue = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      actualValue = authViewModel.nameValidator("");

      // Assert
      expect(actualValue, expectedMsg);
    });

    test('should return null on valid name', () {
      // Arrange
      String? actualValue = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      actualValue = authViewModel.nameValidator("Test Name");

      // Assert
      expect(actualValue, null);
    });
  });

  group('emailValidator', () {
    test('should return the correct email error message', () {
      // Arrange
      String? emptyMsg = "";
      String? invalidMsg = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      emptyMsg = authViewModel.emailValidator("");
      invalidMsg = authViewModel.emailValidator("test@");

      // Assert
      expect(emptyMsg, AuthStrings.emptyEmailErrorMsg);
      expect(invalidMsg, AuthStrings.invalidEmailErrorMsg);
    });

    test('should return null on valid email', () {
      // Arrange
      String? actualValue = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      actualValue = authViewModel.emailValidator("test@hotmail.com");

      // Assert
      expect(actualValue, null);
    });
  });

  group('passwordValidator', () {
    test('should return the correct password error message', () {
      // Arrange
      String? emptyMsg = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      emptyMsg = authViewModel.passwordValidator("");

      // Assert
      expect(emptyMsg, AuthStrings.emptyPasswordErrorMsg);
      expect(authViewModel.passwordValidator("1234"), AuthStrings.invalidPasswordErrorMsg);
      expect(authViewModel.passwordValidator("1234@Mj"), AuthStrings.invalidPasswordErrorMsg);
      expect(authViewModel.passwordValidator("12345678Mj"), AuthStrings.invalidPasswordErrorMsg);
      expect(authViewModel.passwordValidator("12345678@j"), AuthStrings.invalidPasswordErrorMsg);
      expect(authViewModel.passwordValidator("12345678@M"), AuthStrings.invalidPasswordErrorMsg);

    });

    test('should return null on valid password', () {
      // Arrange
      String? actualValue = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act
      actualValue = authViewModel.passwordValidator("12345678@QWEsd");

      // Assert
      expect(actualValue, null);
    });
  });

  group('passwordConfirmationValidator', () {
    test('should return the correct confirmation password error message', () {
      // Arrange
      String? emptyMsg = "";
      String? invalidMsg = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act

      // Set password
      authViewModel.onPasswordChange("dfdf");
      emptyMsg = authViewModel.passwordConfirmationValidator("");
      invalidMsg = authViewModel.passwordConfirmationValidator("1234");

      // Assert
      expect(emptyMsg, AuthStrings.emptyConfirmationPasswordErrorMsg);
      expect(invalidMsg, AuthStrings.passwordDoesNotMatchErrorMsg);
    });

    test('should return null on valid confirmation password', () {
      // Arrange
      String password = "12345678@QWEsd";
      String? actualValue = "";
      final AuthViewModel authViewModel = AuthViewModel(authService);

      // Act

      // Set password
      authViewModel.onPasswordChange(password);
      actualValue = authViewModel.passwordConfirmationValidator(password);

      // Assert
      expect(actualValue, null);
    });
  });
}
