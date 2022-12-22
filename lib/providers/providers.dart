import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/screens/home/homeBody.dart';
import 'package:partirecept/services/authService.dart';

/**
 * Get AuthService instance
 */
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/**
 * recipe index counter provider is used to keep track of recipe pages indexes
 */
final recipeIndexCounterStateProvider = StateProvider<int>((ref) {
  return 0;
});

/**
 * bottom navigation index counter provider is used to keep track of page indexes
 */
final bottomNavigationIndexCounterStateProvider = StateProvider<int>((ref) {
  return 0;
});

/**
 * Keep track of which menu item has been click in MyRecipe page
 */
final menuItemStateProvider = StateProvider<String>((ref) {
  return "";
});

/**
 * Bottom navigation body state notifier is used to change between the pages
 */
final bottomNavigationStateNotifier =
    StateNotifierProvider<BottomNavigationBodyNotifier, Widget>(
        (providerReference) => BottomNavigationBodyNotifier());

/**
 * Bottom navigation body notifier is used for the logic of final bottom navigation stateNotifier
 */
class BottomNavigationBodyNotifier extends StateNotifier<Widget> {
  BottomNavigationBodyNotifier() : super(HomeBody());

  // Changes pages
  void changeBody(Widget body) {
    state = body;
  }
}

/**
 * Returns a user stream when the user sign in or sign out
 */

final firebaseUserStreamProvider =
    StreamProvider<User?>((ref) => AuthService().user);

final recipeFilterNameProvider = StateProvider<String>((ref) {
  return "";
});
