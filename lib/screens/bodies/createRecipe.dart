import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/providers/recipeProviders.dart';
import 'package:partirecept/services/authService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partirecept/constants/colors.dart';
import 'package:partirecept/services/recipeService.dart';
import 'package:partirecept/themes/TextThemeOswald.dart';
import 'package:partirecept/utilities/userFeedback.dart';
import 'package:partirecept/widgets/common/customAppBar.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class CreateRecipe extends ConsumerWidget {
  //Declare fields
  late final buttonText;
  late final titleText;
  final bool agreement = false;
  final int average_rating = 0;
  String cooked_in_kruisstraat = '';
  final int cooking_time = 0; //change
  String description = '';
  final int difficulty = 1; //change
  final String eatery = ''; //change
  final String hashtags = ''; //change
  final String image = '';
  var ingredient_id = [
    FirebaseFirestore.instance
        .collection('ingredient')
        .doc('DUW4CJKuInxNuVqhV7VD'),
    FirebaseFirestore.instance
        .collection('ingredient')
        .doc('CwzEERMJtAmBWYNO5enX')
  ];
  String motivation = ''; //not
  final String origin = ''; //not
  final int portion = 0; //change
  String preparation = ''; //not
  final int ratings_count = 0;
  String recipe_name = ''; //not
  final String recipe_type = ''; //change
  String serving_tips = ''; //not
  final DocumentReference user_id = FirebaseFirestore.instance
      .collection('user')
      .doc(AuthService().getAuthUser()?.uid ?? "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Recipe is for keeping track if this page is for creating or update a recipe
  late final Recipe? recipe;

  //Declare controllers
  TextEditingController cookingTimeController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController difficultyController = new TextEditingController();

  //TextEditingController eateryController = new TextEditingController();
  //TextEditingController hashtagsController = new TextEditingController();
  TextEditingController motivationController = new TextEditingController();
  TextEditingController originController = new TextEditingController();
  TextEditingController portionController = new TextEditingController();
  TextEditingController preparationController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  //TextEditingController typeController = new TextEditingController();
  TextEditingController servingTipsController = new TextEditingController();

  CreateRecipe({Recipe? recipe}) {
    // Check if page is used for create or update recipe
    // If recipe is not null then use page to update recipe
    if (recipe != null) {
      this.recipe = recipe;
      buttonText = "Update";
      titleText = "Edit recipe";

      // Initialize all controller with initial values from recipe
      setControllersInitialValue(recipe);
    } else {
      this.recipe = null;
      buttonText = "Create Recipe";
      titleText = "Add a new recipe";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> addRecipe() async {
      final recipe = getRecipe();

      try {
        final form = _formKey.currentState;

        if (form!.validate()) {
          final recipeService =
              ref.read<RecipeService?>(RecipeProviders.recipeServiceProvider)!;
          await recipeService.addRecipe(Recipe.fromMap(recipe, ""));

          // Pop current screen
          Navigator.pop(context);

          showSnackBar(context, "Recipe added");
        }
      } catch (e) {
        showSnackBar(context, "Error adding recipe!");
      }
    }

    customTextField(String labelText, String hintText,
        TextEditingController Controller, String field,
        {TextInputType? textInputType}) {
      return TextFormField(
          onFieldSubmitted: (String value) {
            field = value;
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please enter a value!";
            }
          },
          keyboardType: textInputType,
          controller: Controller,
          decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              labelStyle: TextStyle(fontSize: 25.0, color: primaryBlack),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.only(top: 50.0)));
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        color: secondaryYellow,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 150,
                        height: 150,
                      ),
                    )
                  ]),
                  Row(children: [
                    Expanded(
                      child: Text(
                        titleText,
                        textAlign: TextAlign.center,
                        style: TextThemeOswald(Colors.black).headline3,
                      ),
                    ),
                  ]),
                  Row(children: [
                    Expanded(
                      child: Text(
                        'For other people to see',
                        textAlign: TextAlign.center,
                        style: TextThemeOswald(Colors.black).subtitle1,
                      ),
                    ),
                  ])
                ]),
                customTextField(
                    'Name', 'Name of recipe', nameController, recipe_name),
                Container(
                  child: const Text.rich(
                    TextSpan(
                      text: 'Cuisine type',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryBlack,
                      ), // default text style
                    ),
                  ),
                  padding: EdgeInsets.only(top: 50.0),
                ),
                CuisineTypeDropDown(cuisineType: recipe?.type),
                customTextField('Portion', 'How many portions is it',
                    portionController, portion.toString(),
                    textInputType: TextInputType.number),
                customTextField(
                    'Cooking time (minutes)',
                    'How much time it will take to prepare',
                    cookingTimeController,
                    cooking_time.toString(),
                    textInputType: TextInputType.number),
                customTextField('Preparation', 'Preparation instructions',
                    preparationController, preparation),
                Container(
                  child: const Text.rich(
                    TextSpan(
                      text: 'Difficulty',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryBlack,
                      ), // default text style
                    ),
                  ),
                  padding: EdgeInsets.only(top: 50.0),
                ),
                DifficultyDropdown(difficulty: recipe?.difficulty),
                Container(
                  child: const Text.rich(
                    TextSpan(
                      text: 'Eatery',
                      style: TextStyle(
                        fontSize: 18,
                        color: primaryBlack,
                      ), // default text style
                    ),
                  ),
                  padding: EdgeInsets.only(top: 50.0),
                ),
                EateryDropdown(eatery: recipe?.eatery),
                customTextField(
                    'Motivation',
                    'Motivation for making the recipe',
                    motivationController,
                    motivation),
                customTextField('Serving tips', 'Tips for serving the meal',
                    servingTipsController, serving_tips),
                customTextField(
                    'Origin', 'Country of origin', originController, origin),
                // TextField(
                //    // onSubmitted: (String value) { difficulty = value;},
                //     controller: difficultyController,
                //     decoration:  InputDecoration(
                //         labelText: 'labelText',
                //         hintText: 'hintText',
                //         hintText: 'hintText',
                //         labelStyle: TextStyle(fontSize: 25.0, color: primaryBlack),
                //         floatingLabelBehavior: FloatingLabelBehavior.always,
                //         contentPadding: EdgeInsets.only(top: 50.0)
                //     )
                // ),
                customTextField('Description', 'Description of recipe',
                    descriptionController, description),

                //Button
                new Container(
                  margin: const EdgeInsets.only(top: 50.0, bottom: 30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryDarkRed),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))),
                    ),
                    onPressed: () => {
                      if (recipe == null)
                        {addRecipe()}
                      else
                        {
                          _updateRecipe(
                              context,
                              ref,
                              Recipe.fromMap(
                                  getRecipe(), (recipe as Recipe).id))
                        }
                    },
                    //  content: Text(difficultyController.text),
                    child: Text(buttonText),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setControllersInitialValue(Recipe recipe) {
    cookingTimeController.text = recipe.cookingTime.toString();
    descriptionController.text = recipe.cooked_in_kruisstraat;
    difficultyController.text = recipe.difficulty.toString();
    motivationController.text = recipe.motivation;
    originController.text = recipe.origin;
    portionController.text = recipe.portion.toString();
    preparationController.text = recipe.preparation;
    nameController.text = recipe.name;
    servingTipsController.text = recipe.servingTips;
  }

  Map<String, dynamic> getRecipe() {
    // Call the ingredient CollectionReference to add a new ingredient
    String cooking_time = cookingTimeController.text;
    String description = descriptionController.text;
    String cooked_in_kruisstraat = descriptionController.text;
    //String difficulty = difficultyController.text;
    //String eatery = eateryController.text;
    //String hashtags = hashtagsController.text;
    String motivation = motivationController.text;
    String origin = originController.text;
    String portion = portionController.text;
    String preparation = preparationController.text;
    String recipe_name = nameController.text;
    //String recipe_type = typeController.text;
    String serving_tips = servingTipsController.text;

    return {
      'agreement': agreement,
      'average_rating': average_rating,
      'cooked_in_kruisstraat': cooked_in_kruisstraat,
      'cooking_time': cooking_time,
      'description': description,
      'difficulty': difficulty,
      'eatery': eatery,
      'hashtags': hashtags,
      'image': image,
      'ingredient_id': ingredient_id,
      'motivation': motivation,
      'origin': origin,
      'portion': portion,
      'preparation': preparation,
      'ratings_count': ratings_count,
      'recipe_name': recipe_name,
      'recipe_type': recipe_type,
      'serving_tips': serving_tips,
      'user_id': user_id,
      'uid': AuthService().getAuthUser()?.uid ?? ""
    };
  }

  Future<void> _updateRecipe(
      BuildContext context, WidgetRef ref, Recipe recipe) async {
    try {
      final FormState? form = _formKey.currentState;

      if (form!.validate()) {
        final recipeService =
            ref.read<RecipeService?>(RecipeProviders.recipeServiceProvider)!;
        await recipeService.updateRecipe(recipe);

        // Pop current screen
        Navigator.pop(context);

        showSnackBar(context, "Recipe updated");
      }
    } catch (e) {
      showSnackBar(context, "Error updating recipe!");
    }
  }
}

class DifficultyDropdown extends StatefulWidget {
  late final int difficulty;

  DifficultyDropdown({Key? key, int? difficulty}) : super(key: key) {
    if (difficulty != null && difficulty != 0) {
      this.difficulty = difficulty;
    } else {
      this.difficulty = 1;
    }
  }

  @override
  State<DifficultyDropdown> createState() =>
      _DifficultyDropdown(difficulty: difficulty);
}

class EateryDropdown extends StatefulWidget {
  late final String eatery;

  EateryDropdown({Key? key, String? eatery}) : super(key: key) {
    if (eatery != null && eatery.isNotEmpty) {
      this.eatery = eatery;
    } else {
      this.eatery = "Breakfast";
    }
  }

  @override
  State<EateryDropdown> createState() => _EateryDropDown(eatery: eatery);
}

class CuisineTypeDropDown extends StatefulWidget {
  late final String cuisineType;

  CuisineTypeDropDown({Key? key, String? cuisineType}) : super(key: key) {
    if (cuisineType != null && cuisineType.isNotEmpty) {
      this.cuisineType = cuisineType;
    } else {
      this.cuisineType = "Main dish";
    }
  }

  @override
  State<CuisineTypeDropDown> createState() =>
      _CuisineTypeDropdown(cuisineType: cuisineType);
}

class _DifficultyDropdown extends State<DifficultyDropdown> {
  int difficulty;

  _DifficultyDropdown({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<int>(
        value: difficulty,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: primaryBlack),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (int? newValue) {
          setState(() {
            difficulty = newValue!;
          });
        },
        items: <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}

class _EateryDropDown extends State<EateryDropdown> {
  String eatery;

  _EateryDropDown({required this.eatery});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: eatery,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: primaryBlack),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (String? newValue) {
          setState(() {
            eatery = newValue!;
          });
        },
        items: <String>['Breakfast', 'Lunch', 'Dinner', 'Brunch', 'Universal']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class _CuisineTypeDropdown extends State<CuisineTypeDropDown> {
  String cuisineType;

  _CuisineTypeDropdown({required this.cuisineType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: cuisineType,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: primaryBlack),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (String? newValue) {
          setState(() {
            cuisineType = newValue!;
          });
        },
        items: <String>['Main dish', 'Side dish', 'Desert']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
