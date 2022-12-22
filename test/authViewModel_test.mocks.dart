// Mocks generated by Mockito 5.0.16 from annotations
// in partirecept/test/authViewModel_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:partirecept/services/authService.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [AuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthService extends _i1.Mock implements _i2.AuthService {
  MockAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<_i4.User?> get user =>
      (super.noSuchMethod(Invocation.getter(#user),
          returnValue: Stream<_i4.User?>.empty()) as _i3.Stream<_i4.User?>);
  @override
  _i3.Future<_i4.User?> signInAnonymously() =>
      (super.noSuchMethod(Invocation.method(#signInAnonymously, []),
          returnValue: Future<_i4.User?>.value()) as _i3.Future<_i4.User?>);
  @override
  _i3.Future<_i4.User?> signInWithEmailAndPassword(
          String? email, String? password) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithEmailAndPassword, [email, password]),
          returnValue: Future<_i4.User?>.value()) as _i3.Future<_i4.User?>);
  @override
  _i3.Future<dynamic> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<dynamic>.value()) as _i3.Future<dynamic>);
  @override
  _i3.Future<_i4.User?> createAccount(
          String? email, String? password, String? name) =>
      (super.noSuchMethod(
          Invocation.method(#createAccount, [email, password, name]),
          returnValue: Future<_i4.User?>.value()) as _i3.Future<_i4.User?>);
  @override
  String toString() => super.toString();
}
