import 'package:firebase_auth/firebase_auth.dart';
import 'package:partirecept/models/userM.dart';
import 'package:partirecept/services/userService.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in anonymously
  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Get user stream on authentication (use to get user sign-in state)
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  // Get current authenticated user (use only for getting uid)
  User? getAuthUser() {
    return _firebaseAuth.currentUser;
  }

  // Sign in with sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<User?> createAccount(
      String email, String password, String name) async {
    try {
      UserService userService = UserService();
      // Create user account
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Add user to the database
      await userService
          .addUser(UserM(result.user?.uid ?? '', name, '', '', '').toJson());
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
