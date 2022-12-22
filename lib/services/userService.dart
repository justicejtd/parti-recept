import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partirecept/services/FirestoreService.dart';

class UserService {
  final fireStoreService = FirestoreService.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  UserService();

  Future addUser(Object object) {
    return users.add(object);
  }
}
