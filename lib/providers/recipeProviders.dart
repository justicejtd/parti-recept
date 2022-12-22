import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/providers/firebaseProviders.dart';
import 'package:partirecept/services/recipeService.dart';

class RecipeProviders {
  /**
   * Get instance of recipe service
   */
  static final recipeServiceProvider = Provider<RecipeService?>((ref) {
    final auth = ref.watch(FirebaseProviders.userStateChangesProvider);
    final uid = auth.asData?.value?.uid;

    if (uid != null) {
      return RecipeService(uid: uid);
    }
    return null;
  });

  /**
   * Get my recipes stream based on uid
   */
  static final myRecipeStreamProvider =
      StreamProvider.autoDispose<List<Recipe>>((ref) {
    final service = ref.watch(recipeServiceProvider)!;
    return service.getMyRecipes();
  });
}
