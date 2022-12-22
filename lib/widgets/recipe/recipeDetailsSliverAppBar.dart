import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/widgets/Animation/loadingSpinner.dart';

class RecipeDetailsSliverAppBar extends StatelessWidget {
  final double borderRadius = 50;
  final Recipe recipe;

  const RecipeDetailsSliverAppBar({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: secondaryYellow,
      floating: true,
      stretch: true,
      shape: RoundedRectangleBorder(
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: CachedNetworkImage(
          placeholder: (context, url) => LoadingSpinner(duration: 3),
          imageUrl: recipe.imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10
                )
              ],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(borderRadius),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      pinned: false,
      expandedHeight: MediaQuery
          .of(context)
          .size
          .height * 0.305,
    );
  }
}