import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/providers/providers.dart';

class FirebaseProviders {
  /**
   * Get instance of firebase auth
   */
  static final firebaseAuthProvider =
  Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

  /**
   * Get a stream of on user changes
   */
  static final userStateChangesProvider = StreamProvider<User?>(
          (ref) => ref.watch(authServiceProvider).user);
}
