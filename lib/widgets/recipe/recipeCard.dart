import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/providers/businessProviders.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/widgets/Animation/loadingSpinner.dart';
import 'package:partirecept/widgets/recipe/recipeRatingRow.dart';

class RecipeCard extends ConsumerWidget {
  final double borderRadius = 20;
  final double sizedBoxHeight = 350;
  final Recipe recipe;

  RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final business =
        ref.watch(BusinessProviders.businessStreamProvider(recipe.businessId));

    return SizedBox(
      height: sizedBoxHeight,
      child: CachedNetworkImage(
        placeholder: (context, url) => LoadingSpinner(duration: 1),
        imageUrl: recipe.imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Card(
              color: Color(0x80000000),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            recipe.name,
                            textAlign: TextAlign.center,
                            style: TextThemeOswald(Colors.white).headline3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${recipe.cookingTime} min',
                          textAlign: TextAlign.center,
                          style: TextThemeOswald(Colors.white).headline6,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: business.when(
                            data: (business) => Text(
                              '${business.name}',
                              textAlign: TextAlign.center,
                              style: TextThemeOswald(Colors.white).headline6,
                            ),
                            error: (_, e) => Text(
                              "Unknown business",
                              textAlign: TextAlign.center,
                              style: TextThemeOswald(Colors.white).headline6,
                            ),
                            loading: () => LoadingSpinner(duration: 3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: RecipeRatingRow(
                      recipe: recipe,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
