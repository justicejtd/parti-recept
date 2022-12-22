import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsPage.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/Animation/loadingSpinner.dart';
import 'package:partirecept/widgets/recipe/recipeCard.dart';

class RecipePageView extends StatelessWidget {
  final Stream<QuerySnapshot> _collectionRecipeStream =
      FirebaseFirestore.instance.collection('recipe').snapshots();

  RecipePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _collectionRecipeStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error.toString()}',
              style: TextThemeOswald(Colors.red).headline1,
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner(duration: 1);
          }

          if (!snapshot.hasData) {
            return Text(
              'No recipe found!',
              style: TextThemeOswald(Colors.red).headline1,
            );
          }

          return SizedBox(
            height: 400,
            child: Consumer(builder: (context, ref, child) {
              StateController<int> _recipeIndexController =
                  ref.watch(recipeIndexCounterStateProvider.state);
              return PageView.builder(
                  pageSnapping: true,
                  itemCount: snapshot.data!.size,
                  scrollDirection: Axis.horizontal,
                  controller: PageController(
                      viewportFraction: 0.7,
                      initialPage: _recipeIndexController.state),
                  onPageChanged: (int index) {
                    _recipeIndexController.state = index;
                  },
                  itemBuilder: (context, i) {
                    final recipeDocument = snapshot.data!.docs[i];
                    final recipe = Recipe.convertDocument(recipeDocument);

                    return Transform.scale(
                        scale: i == _recipeIndexController.state ? 1 : 0.8,
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Stack(children: [
                              RecipeCard(
                                recipe: recipe,
                              ),
                              Positioned.fill(
                                  child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () =>
                                      _showDetailScreen(context, recipe),
                                ),
                              )),
                            ]),
                          ],
                        ));
                  });
            }),
          );
        });
  }

  void _showDetailScreen(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecipeDetailsPage(recipe: recipe)),
    );
  }
}
