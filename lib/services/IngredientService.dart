// import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:partirecept/models/ingredient.dart';
//
// abstract class IngredientRepo {
//   Future<List<Ingredient>> getAllIngredients();
// }
//
// class IngredientRepository implements IngredientRepo {
//   final Reader _reader;
//
//   IngredientRepository(this._reader);
//
//   @override
//   Future<List<Ingredient>> getAllIngredients() {
//     try {
//       //final fireStore = _reader(fire)
//       Future<List<Ingredient>> ingredients;
//
//       return ingredients;
//     } on FirebaseException catch (e) {
//       window.console.error(e.message);
//     }
//   }
//
// }
