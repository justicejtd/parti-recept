import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/ingredient.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsBody.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/Animation/loadingSpinner.dart';
import 'package:partirecept/widgets/map/location_map.dart';

class IngredientsDetailsRow extends StatelessWidget {
  final Recipe recipe;
  final Stream<QuerySnapshot> _collectionIngredientStream =
      FirebaseFirestore.instance.collection('ingredient').snapshots();

  IngredientsDetailsRow({Key? key, required this.recipe}) : super(key: key);

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
                    Text(
                      'Ingredients',
                      style: TextThemeOswald(Colors.black).headline4,
                    ),
                  ],
                ),
                Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: _collectionIngredientStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error.toString()}',
                              style: TextThemeOswald(Colors.red).headline1,
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingSpinner(duration: 3);
                          }

                          if (!snapshot.hasData) {
                            return Text(
                              'No ingredient found!',
                              style: TextThemeOswald(Colors.red).headline1,
                            );
                          }

                          List<Ingredient> ingredients =
                              getFilteredIngredients(snapshot);

                          return Expanded(
                            child: Column(
                                children: ingredients
                                    .map(
                                      (ingredient) => ListTile(
                                        leading: Icon(Icons.circle),
                                        title: OverflowBar(
                                          children: [
                                            Text(
                                              ingredient.ingredientName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryBlack,
                                                  fontSize: TextThemeOswald(
                                                          primaryBlack)
                                                      .headline5
                                                      ?.fontSize),
                                            ),
                                            InkWell(
                                              onTap: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomMap(
                                                              markerToBeCentered:
                                                                  ingredient
                                                                      .businessId)),
                                                ),
                                              },
                                              child: Text(
                                                  '${ingredient.businessId != null ? " (Can be found here)" : ""}',
                                                  style: TextThemeOswald(
                                                          Colors.white)
                                                      .bodyText2),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                            'Amount: ${ingredient.amount}',
                                            style:
                                                TextThemeOswald(primaryBlack)
                                                    .headline6),
                                      ),
                                    )
                                    .toList()),
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Ingredient> getFilteredIngredients(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    final ingredientDocuments = snapshot.data;
    List<Ingredient> ingredients = [];

    for (int i = 0; i < recipe.ingredients.length; i++) {
      var ingredientRef = recipe.ingredients[i];
      for (int i2 = 0; i2 < ingredientDocuments!.size; i2++) {
        try {
          var ingredient =
              Ingredient.covertDocument(ingredientDocuments.docs[i2]);
          if (ingredientDocuments.docs[i2].reference.id == ingredientRef.id) {
            ingredients.add(ingredient);
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return ingredients;
  }
}
