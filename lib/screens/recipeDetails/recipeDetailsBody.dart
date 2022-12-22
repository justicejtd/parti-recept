import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/common/horizontalLine.dart';
import 'package:partirecept/widgets/recipe/authorRecipeDetailsRow.dart';
import 'package:partirecept/widgets/recipe/commentsRecipeButtonRow.dart';
import 'package:partirecept/widgets/recipe/ingredientsRecipeDetailsRow.dart';
import 'package:partirecept/widgets/recipe/preparationRecipeDetailsRow.dart';
import 'package:partirecept/widgets/recipe/recipeRatingRow.dart';
import 'package:partirecept/widgets/recipe/stepsRecipeDetailsRow.dart';

class RecipeDetailsBody extends StatelessWidget {
  final Recipe recipe;
  static const double padding = 10;
  static const double paddingBottom = 20;
  static const double iconSize = 40;

  RecipeDetailsBody({Key? key, required this.recipe}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryYellow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                padding, padding, padding, paddingBottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(recipe.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: TextThemeOswald(Colors.black).headline2?.fontSize,
                            fontWeight: FontWeight.bold)),
                    RecipeRatingRow(key: key, recipe: recipe),
                  ],
                )
              ],
            ),
          ),
          HorizontalLine(size: Size(MediaQuery.of(context).size.width / 1.1, 1), color: primaryBlack,),
          PreparationRecipeDetailsRow(recipe: recipe),
          HorizontalLine(size: Size(MediaQuery.of(context).size.width / 1.1, 1), color: primaryBlack,),
          IngredientsDetailsRow(recipe: recipe),
          HorizontalLine(size: Size(MediaQuery.of(context).size.width / 1.1, 1), color: primaryBlack,),
          StepsRecipeDetailsRow(recipe: recipe),
          HorizontalLine(size: Size(MediaQuery.of(context).size.width / 1.1, 1), color: primaryBlack,),
          CommentsRecipeButtonRow(recipeKey: recipe.id),
          HorizontalLine(size: Size(MediaQuery.of(context).size.width / 1.1, 1), color: primaryBlack,),
          AuthorRecipeDetailsRow(recipe: recipe),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, paddingBottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image(image: AssetImage('assets/images/logo.png'), width: 80, height: 80,),
                    Text("Bon appetite!", style: TextThemeOswald(Colors.black).headline6,)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
