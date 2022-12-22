import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsBody.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';

class StepsRecipeDetailsRow extends StatelessWidget {
  final Recipe recipe;

  const StepsRecipeDetailsRow({Key? key, required this.recipe})
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
                      'Steps',
                      style: TextThemeOswald(Colors.black).headline4,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${recipe.steps}',
                        style: TextThemeOswald(primaryBlack).bodyText1,
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
