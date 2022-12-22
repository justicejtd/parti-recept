import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:partirecept/constants/authStrings.dart';
import 'package:partirecept/providers/authProviders.dart';
import 'package:partirecept/screens/authenticaiton/authViewModel.dart';
import 'package:partirecept/screens/authenticaiton/loginPage.dart';
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
                child: new MaterialApp(home: new LoginPage())),
          ));

          // Finder
          final customTFEmailFinder = find.byKey(Key("customTFEmail"));
          final customTFPasswordFinder = find.byKey(Key("customTFPassword"));

          // Matcher
          expect(customTFEmailFinder, findsOneWidget);
          expect(customTFPasswordFinder, findsOneWidget);
        });
  });

  group("On login button click", () {
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
                child: new MaterialApp(home: new LoginPage())),
          ));

          // Return empty error message when validator is called
          when(authViewModel.emailValidator(""))
              .thenReturn(AuthStrings.emptyEmailErrorMsg);
          when(authViewModel.passwordLoginValidator(""))
              .thenReturn(AuthStrings.emptyPasswordErrorMsg);

          // Finder
          final loginBtnFinder = find.widgetWithText(ElevatedButton, "Login");

          // Matcher
          expect(loginBtnFinder, findsOneWidget);

          // Act
          await tester.tap(loginBtnFinder);
          await tester.pump();

          // Matcher
          // Check if error message is shown
          expect(find.text(AuthStrings.emptyEmailErrorMsg), findsOneWidget);
          expect(find.text(AuthStrings.emptyPasswordErrorMsg), findsOneWidget);
        });

    testWidgets("should show error message on invalid input value",
            (tester) async {
          // Arrange
          final invalidPassword = "sdafsd";

          // Build widget
          await tester.pumpWidget(ProviderScope(
            overrides: [
              // Override the behavior of authVMProvider to return
              // MockAuthViewModel instead of AuthViewModel.
              authVMProvider.overrideWithValue(authViewModel)
            ],
            child: new MediaQuery(
                data: new MediaQueryData(),
                child: new MaterialApp(home: new LoginPage())),
          ));

          // Return empty error message when validator is called
          when(authViewModel.emailValidator(""))
              .thenReturn(AuthStrings.invalidEmailErrorMsg);
          when(authViewModel.passwordLoginValidator(invalidPassword))
              .thenReturn(null);
          when(authViewModel.onPasswordChange(invalidPassword)).thenAnswer((realInvocation) => () =>{});

          // Finder
          final loginBtnFinder = find.widgetWithText(ElevatedButton, "Login");
          final customTFPasswordFinder = find.byKey(Key("customTFPassword"));

          // Act
          await tester.enterText(customTFPasswordFinder, invalidPassword);

          // Matcher
          expect(loginBtnFinder, findsOneWidget);

          // Act
          await tester.tap(loginBtnFinder);
          await tester.pump();

          // Matcher
          // Check if error message is shown
          expect(find.text(AuthStrings.invalidEmailErrorMsg), findsOneWidget);
          expect(find.text(AuthStrings.invalidPasswordErrorMsg), findsNothing);
        });
  });
}
