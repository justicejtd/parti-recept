import 'package:flutter/material.dart';
import 'package:partirecept/widgets/recipe/recipeListView.dart';

class FilterBody extends StatelessWidget {
  const FilterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: RecipeListView());
  }
}
