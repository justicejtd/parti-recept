import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  //collection refference
  //final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipes');
  CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');

}