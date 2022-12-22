import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:partirecept/constants/authStrings.dart';
import 'package:partirecept/providers/authProviders.dart';
import 'package:partirecept/screens/authenticaiton/authViewModel.dart';
import 'package:partirecept/screens/authenticaiton/registrationPage.dart';

import 'loginPage_widget_test.mocks.dart';


@GenerateMocks([AuthViewModel])
void main() {
  final authViewModel = MockAuthViewModel();

  group("Registration Page", () {
    testWidgets('should have all required text fields',
        (WidgetTester tester) async {
      // Build widget
      await tester.pumpWidget(ProviderScope(
        overrides: [
          // Override the behavior of authVMProvider to return
          // MockAuthViewModel instead of AuthViewModel.
          authVMProvider.overrideWithValue(authViewModel)
        ],
        child: new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new RegistrationPage())),
      ));

      // Finder
      final customTFEmailFinder = find.byKey(Key("customTFEmail"));
      final customTFNameFinder = find.byKey(Key("customTFName"));
      final customTFPasswordFinder = find.byKey(Key("customTFPassword"));
      final customTFConfirmationPassFinder =
          find.byKey(Key("customTFConfirmationPassword"));

      // Matcher
      expect(customTFEmailFinder, findsOneWidget);
      expect(customTFNameFinder, findsOneWidget);
      expect(customTFPasswordFinder, findsOneWidget);
      expect(customTFConfirmationPassFinder, findsOneWidget);
    });
  });

  group("On register button click", () {
    testWidgets("should show error message on empty input values",
        (tester) async {
      // Build widget
      await tester.pumpWidget(ProviderScope(
        overrides: [
          // Override the behavior of authVMProvider to return
          // MockAuthViewModel instead of AuthViewModel.
          authVMProvider.overrideWithValue(authViewModel)
        ],
        child: new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new RegistrationPage())),
      ));

      // Return empty error message when validator is called
      when(authViewModel.emailValidator(""))
          .thenReturn(AuthStrings.emptyEmailErrorMsg);
      when(authViewModel.nameValidator(""))
          .thenReturn(AuthStrings.emptyNameErrorMsg);
      when(authViewModel.passwordValidator(""))
          .thenReturn(AuthStrings.emptyPasswordErrorMsg);
      when(authViewModel.passwordConfirmationValidator(""))
          .thenReturn(AuthStrings.emptyConfirmationPasswordErrorMsg);

      // Finder
      final registerBtnFinder = find.widgetWithText(ElevatedButton, "Register");

      // Matcher
      expect(registerBtnFinder, findsOneWidget);

      // Act
      await tester.tap(registerBtnFinder);
      await tester.pump();

      // Matcher
      // Check if error message is shown
      expect(find.text(AuthStrings.emptyEmailErrorMsg), findsOneWidget);
      expect(find.text(AuthStrings.emptyNameErrorMsg), findsOneWidget);
      expect(find.text(AuthStrings.emptyPasswordErrorMsg), findsOneWidget);
      expect(find.text(AuthStrings.emptyConfirmationPasswordErrorMsg),
          findsOneWidget);
    });

    testWidgets("should show error message on invalid input value",
        (tester) async {
      // Build widget
      await tester.pumpWidget(ProviderScope(
        overrides: [
          // Override the behavior of authVMProvider to return
          // MockAuthViewModel instead of AuthViewModel.
          authVMProvider.overrideWithValue(authViewModel)
        ],
        child: new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(home: new RegistrationPage())),
      ));

      // Return empty error message when validator is called
      when(authViewModel.emailValidator(""))
          .thenReturn(AuthStrings.invalidEmailErrorMsg);
      when(authViewModel.passwordValidator(""))
          .thenReturn(AuthStrings.invalidPasswordErrorMsg);
      when(authViewModel.nameValidator("")).thenReturn("");
      when(authViewModel.passwordConfirmationValidator(""))
          .thenReturn(AuthStrings.passwordDoesNotMatchErrorMsg);

      // Finder
      final registerBtnFinder = find.widgetWithText(ElevatedButton, "Register");

      // Matcher
      expect(registerBtnFinder, findsOneWidget);

      // Act
      await tester.tap(registerBtnFinder);
      await tester.pump();

      // Matcher
      // Check if error message is shown
      expect(find.text(AuthStrings.invalidEmailErrorMsg), findsOneWidget);
      expect(find.text(AuthStrings.invalidPasswordErrorMsg), findsOneWidget);
      expect(
          find.text(AuthStrings.passwordDoesNotMatchErrorMsg), findsOneWidget);
    });
  });
}
