import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  String _amount = "";
  late dynamic _businessId;
  String _ingredientName = "";
  late DocumentReference _recipeId;

  Ingredient.covertDocument(QueryDocumentSnapshot recipeDocument) {
    Map<String, dynamic> documentFields =
        recipeDocument.data() as Map<String, dynamic>;

    _amount = recipeDocument.get('amount') ?? "";
    if (documentFields['business_id'] != null) {
      _businessId = recipeDocument.get('business_id') ?? "";
    } else {
      _businessId = null;
    }
    _ingredientName = recipeDocument.get('ingredient_name') ?? "";
    _recipeId = recipeDocument.get('recipe_id') ?? "";
  }

  DocumentReference get recipeId => _recipeId;

  String get ingredientName => _ingredientName;

  dynamic get businessId => _businessId;

  String get amount => _amount.length > 0 ? _amount : "Not specified";
}
