import 'package:flutter/material.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsBody.dart';
import 'package:partirecept/widgets/recipe/recipeDetailsSliverAppBar.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        RecipeDetailsSliverAppBar(recipe: recipe),
        SliverList(
          delegate: SliverChildListDelegate([
            RecipeDetailsBody(recipe: recipe),
          ]),
        ),
      ],
    ));
  }
}
