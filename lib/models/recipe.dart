import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String _id = "";
  String _name = "";
  String _businessId = "";
  int _cookingTime = 0;
  String _cooked_in_kruisstraat = "";
  String _servingTips = "";
  int _difficulty = 0;
  String _type = "";
  List<dynamic> _ingredients = [];
  String _preparation = "";
  String _motivation = "";
  String _imageUrl = "";
  String _eatery = "";
  String _origin = "";
  int _portion = 0;
  int _avgRating = 0;
  int _ratingsCount = 0;
  String _uid = "";

  Recipe(
      this._id,
      this._name,
      this._cookingTime,
      this._cooked_in_kruisstraat,
      this._servingTips,
      this._difficulty,
      this._type,
      this._ingredients,
      this._preparation,
      this._motivation,
      this._imageUrl,
      this._eatery,
      this._origin,
      this._portion,
      this._avgRating,
      this._ratingsCount,
      this._uid);

  Recipe.convertDocument(QueryDocumentSnapshot doc) {
    _id = doc.id;
    _businessId = doc.data().toString().contains("business")
        ? doc.get('business_id')
        : "";
    _name = doc['recipe_name'].toString();
    _cookingTime = int.parse(doc['cooking_time'].toString());
    _cooked_in_kruisstraat = doc['cooked_in_kruisstraat'];
    _servingTips = doc['serving_tips'];
    _difficulty = doc['difficulty'];
    _type = doc['recipe_type'];
    _ingredients = doc['ingredient_id'];
    _preparation = doc['preparation'];
    _motivation = doc['motivation'];
    _imageUrl = doc['image'] == ""
        ? "https://firebasestorage.googleapis.com/v0/b/partirecept.appspot.com/o/no-image.jpg?alt=media&token=fb88b8e0-4173-477e-b4e0-9b3a5f244ff2"
        : doc['image'];
    _origin = doc['origin'];
    _eatery = doc['eatery'];
    _portion = int.parse(doc['portion'].toString());
    _ratingsCount = doc['ratings_count'];
    _avgRating = doc['average_rating'];
    _uid = doc.data().toString().contains('uid')
        ? doc.get('uid')
        : "";
  }

  Recipe.fromMap(Map<String, dynamic>? data, String docId) {
    if (data != null) {
      _id = docId;
      _businessId =
          data.toString().contains('business') ? data['business_id'] : "";
      _name = data['recipe_name'].toString();
      _cookingTime = int.parse(data['cooking_time'].toString());
      _cooked_in_kruisstraat = data['cooked_in_kruisstraat'];
      _servingTips = data['serving_tips'];
      _difficulty = data['difficulty'];
      _type = data['recipe_type'];
      _ingredients = data['ingredient_id'];
      _preparation = data['preparation'];
      _motivation = data['motivation'];
      _imageUrl = data['image'] == ""
          ? "https://firebasestorage.googleapis.com/v0/b/partirecept.appspot.com/o/no-image.jpg?alt=media&token=fb88b8e0-4173-477e-b4e0-9b3a5f244ff2"
          : data['image'];
      _origin = data['origin'];
      _eatery = data['eatery'];
      _portion = int.parse(data['portion'].toString());
      _ratingsCount = data['ratings_count'];
      _avgRating = data['average_rating'];
      _uid = data['uid'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'average_rating': _avgRating,
      'cooked_in_kruisstraat': _cooked_in_kruisstraat,
      'cooking_time': _cookingTime,
      'difficulty': _difficulty,
      'eatery': _eatery,
      'image': _imageUrl,
      'ingredient_id': _ingredients,
      'motivation': _motivation,
      'origin': _origin,
      'portion': _portion,
      'preparation': _preparation,
      'ratings_count': _ratingsCount,
      'recipe_name': _name,
      'recipe_type': _type,
      'serving_tips': _servingTips,
      'uid': _uid
    };
  }

  String get id => _id;

  String get businessId => _businessId;

  String get name => _name;

  String get imageUrl => _imageUrl;

  String get authorNotes => _motivation;

  String get steps => _preparation;

  List<dynamic> get ingredients => _ingredients;

  String get type => _type;

  int get avgRating => _avgRating;

  int get ratingCount => _ratingsCount;

  int get portion => _portion;

  String get origin => _origin;

  String get eatery => _eatery;

  String get motivation => _motivation;

  String get preparation => _preparation;

  int get difficulty => _difficulty;

  String get servingTips => _servingTips;

  String get cooked_in_kruisstraat => _cooked_in_kruisstraat;

  int get cookingTime => _cookingTime;

  int get ratingsCount => _ratingsCount;
}
