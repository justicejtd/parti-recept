import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/screens/authenticaiton/authViewModel.dart';

/**
 * Get instance of AuthViewModel
 */
final authVMProvider = Provider<AuthViewModel>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthViewModel(authService);
});

/**
 * Keeps track of the error message of the verification
 */
final authErrorMsgStateProvider = StateProvider<String>((ref) => "");
