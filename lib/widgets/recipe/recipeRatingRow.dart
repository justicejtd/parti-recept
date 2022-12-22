import 'package:flutter/material.dart';
import 'package:partirecept/models/recipe.dart';

class RecipeRatingRow extends StatelessWidget {
  final Recipe recipe;

  const RecipeRatingRow({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 8),
        Icon(Icons.star_rate, size: 24.0, color: Colors.amberAccent),
        Icon(Icons.star_rate, size: 24.0, color: Colors.amberAccent),
        Icon(Icons.star_rate, size: 24.0, color: Colors.amberAccent),
        Icon(Icons.star_rate, size: 24.0, color: Colors.grey),
        Icon(Icons.star_rate, size: 24.0, color: Colors.grey),
      ],
    );
  }
}
