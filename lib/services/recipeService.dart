import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/services/FirestoreService.dart';
import 'package:partirecept/utilities/firestorePath.dart';

class RecipeService {
  final String uid;
  final _fireStoreService = FirestoreService.instance;

  RecipeService({required this.uid});

  Stream<List<Recipe>> getMyRecipes() {
    // Return collection of recipes based on current user id
    return _fireStoreService.collectionStream(
        path: FirestorePath.recipes(),
        builder: (Map<String, dynamic>? data, String documentID) =>
            Recipe.fromMap(data, documentID),
        queryBuilder: (query) => query.where("uid", isEqualTo: uid));
  }

  Future<void> updateRecipe(Recipe recipe) => _fireStoreService.setData(
      path: FirestorePath.recipe(recipe.id), data: recipe.toMap(), merge: true);

  Future<void> addRecipe(Recipe recipe) => _fireStoreService.addData(
      path: FirestorePath.recipes(), data: recipe.toMap());

  Future<void> deleteRecipe(Recipe recipe) =>
      _fireStoreService.deleteData(path: FirestorePath.recipe(recipe.id));
}
