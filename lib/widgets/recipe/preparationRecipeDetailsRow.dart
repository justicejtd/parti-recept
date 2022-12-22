import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsBody.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';

class PreparationRecipeDetailsRow extends StatelessWidget {
  final Recipe recipe;

  const PreparationRecipeDetailsRow({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                RecipeDetailsBody.padding,
                RecipeDetailsBody.padding,
                RecipeDetailsBody.padding,
                RecipeDetailsBody.paddingBottom),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Preparation',
                        style: TextThemeOswald(Colors.black).headline4),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(RecipeDetailsBody.padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            size: RecipeDetailsBody.iconSize,
                          ),
                          Text('${recipe.cookingTime}',
                              style: TextThemeOswald(primaryBlack).subtitle1),
                          Text('min',
                              style: TextThemeOswald(primaryBlack).subtitle1),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          size: RecipeDetailsBody.iconSize,
                        ),
                        Text('${recipe.portion}',
                            style: TextThemeOswald(primaryBlack).subtitle1),
                        Text('Servings',
                            style: TextThemeOswald(primaryBlack).subtitle1),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.flag,
                          size: RecipeDetailsBody.iconSize,
                        ),
                        Text(recipe.origin,
                            style: TextThemeOswald(primaryBlack).subtitle1),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
