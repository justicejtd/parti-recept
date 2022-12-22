import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsBody.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';

class AuthorRecipeDetailsRow extends StatelessWidget {
  final Recipe recipe;

  const AuthorRecipeDetailsRow({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(RecipeDetailsBody.padding, RecipeDetailsBody.padding, RecipeDetailsBody.padding, RecipeDetailsBody.paddingBottom),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Author Notes',
                      style: TextThemeOswald(Colors.black).headline4,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        recipe.authorNotes,
                        style: TextThemeOswald(primaryBlack).subtitle1,
                      ),
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
