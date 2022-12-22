class FirestorePath {
  static String business(String businessId) => "business/$businessId";
  static String recipes() => "recipe";
  static String recipe(String recipeId) => "recipe/$recipeId";
  static String user() => "user";
}
