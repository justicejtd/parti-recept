import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/constants/myRecipeMenu.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/providers/providers.dart';
import 'package:partirecept/providers/recipeProviders.dart';
import 'package:partirecept/screens/bodies/createRecipe.dart';
import 'package:partirecept/services/recipeService.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/utilities/listItemBuilder.dart';
import 'package:partirecept/utilities/navigation.dart';
import 'package:partirecept/utilities/userFeedback.dart';
import 'package:partirecept/widgets/recipe/recipeCard.dart';

class MyRecipe extends ConsumerWidget {
  const MyRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myRecipeStream = ref.watch(RecipeProviders.myRecipeStreamProvider);
    return Column(children: <Widget>[
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(children: [
              ListItemsBuilder<Recipe>(
                data: myRecipeStream,
                itemBuilder: (context, recipe) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                    child: Stack(children: [
                      RecipeCard(recipe: recipe),
                      Align(
                        alignment: Alignment.topRight,
                        child: MyRecipePopUpMenu(
                          recipe: recipe,
                        ),
                      )
                    ]),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: primaryOrange,
                    onPressed: () => pushScreen(context, CreateRecipe()),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ))
    ]);
  }
}

class MyRecipePopUpMenu extends ConsumerWidget {
  final Recipe recipe;

  MyRecipePopUpMenu({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItemState = ref.watch(menuItemStateProvider.state);

    return PopupMenuButton(
      onSelected: (value) {
        // Change the state of the menu item value
        menuItemState.state = value.toString();

        // Check which menu item has been clicked
        if (value == MyRecipeMenu.edit) {
          pushScreen(context, CreateRecipe(recipe: recipe));
        } else if (value == MyRecipeMenu.delete) {
          _deleteRecipe(context, ref, recipe);
        }
      },
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: MyRecipeMenu.edit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              MyRecipeMenu.edit,
              style: TextThemeOswald(Colors.black).bodyText1,
            ),
          ),
        ),
        PopupMenuItem(
          value: MyRecipeMenu.delete,
          child: ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text(
              MyRecipeMenu.delete,
              style: TextThemeOswald(Colors.black).bodyText1,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _deleteRecipe(
      BuildContext context, WidgetRef ref, Recipe recipe) async {
    try {
      final recipeService =
          ref.read<RecipeService?>(RecipeProviders.recipeServiceProvider)!;
      await recipeService.deleteRecipe(recipe);
      showSnackBar(context, "Recipe deleted");
    } catch (e) {
      showSnackBar(context, "Error delete recipe!");
    }
  }
}