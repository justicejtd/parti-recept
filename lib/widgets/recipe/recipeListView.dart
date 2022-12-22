import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partirecept/models/recipe.dart';
import 'package:partirecept/screens/recipeDetails/recipeDetailsPage.dart';
import 'package:partirecept/widgets/recipe/recipeCard.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  String _portionDropdown = 'all';
  String _typeDropdown = 'all';
  String _originDropdown = 'all';
  TextEditingController _searchController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  List<String> _allOrigins = ['all'];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getRecipesStreamSnapshot();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  _onSearchCleared() {
    getRecipesStreamSnapshot();
    setState(() {
      _portionDropdown = 'all';
      _typeDropdown = 'all';
      _originDropdown = 'all';
      _searchController.text = '';
    });
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var recipeSnapshot in _allResults) {
        var title = Recipe.convertDocument(recipeSnapshot).name.toLowerCase();
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(recipeSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    if (_portionDropdown != 'all') {
      var result = List.from(showResults);
      for (var recipeSnapshot in showResults) {
        var cookingTime = Recipe.convertDocument(recipeSnapshot).cookingTime;
        switch (_portionDropdown) {
          case '1': {
            if (cookingTime >= 30) {
              print("removed for case:"+_portionDropdown);
              result.remove(recipeSnapshot);
            }
            break;
          }
          case '2': {
            if (cookingTime < 30 || cookingTime >= 60 ) {
              print("removed for case:"+_portionDropdown);
              result.remove(recipeSnapshot);
            }
            break;
          }
          case '3': {
            if (cookingTime < 60 || cookingTime >= 90 ) {
              print("removed for case:"+_portionDropdown);
              result.remove(recipeSnapshot);
            }
            break;
          }
          case '4': {
            if (cookingTime < 90 ) {
              print("removed for case:"+_portionDropdown);
              result.remove(recipeSnapshot);
            }
            break;
          }
        }
      }
      showResults = result;
    }

    if (_typeDropdown != 'all') {
      var result = List.from(showResults);
      for (var recipeSnapshot in showResults) {
        var recipeType = Recipe.convertDocument(recipeSnapshot).type.toLowerCase();
        if (recipeType != _typeDropdown.toLowerCase()) {
          result.remove(recipeSnapshot);
        }
      }
      showResults = result;
    }

    if(_originDropdown != 'all') {
      var result = List.from(showResults);
      for (var recipeSnapshot in showResults) {
        var origin = Recipe.convertDocument(recipeSnapshot).origin.toLowerCase();
        if (origin != _originDropdown.toLowerCase()) {
          result.remove(recipeSnapshot);
        }
      }
      showResults = result;
    }

    setState(() {
      _resultsList = showResults;
    });
  }

  getRecipesStreamSnapshot() async {
    var data = await FirebaseFirestore.instance.collection('recipe').get();
    setState(() {
      _allResults = data.docs;
    });
    for (var recipeSnapshot in data.docs) {
      var origin = Recipe.convertDocument(recipeSnapshot).origin;
      if (!_allOrigins.contains(origin)) {
        _allOrigins.add(origin);
      }
    }
    searchResultsList();
  }

  void _showDetailScreen(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecipeDetailsPage(recipe: recipe)),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: "Search for a recipe",
                prefixIcon: Icon(Icons.search)
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _typeDropdown,
                  icon: const Icon(Icons.category, color: Colors.white),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black45
                  ),
                  underline: Container(
                    height: 1.5,
                    color: Colors.black38,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _typeDropdown = newValue!;
                      _onSearchChanged();
                    });
                  },
                  items: <String>['all', 'Main dish', 'Dessert', 'Appetizer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
                DropdownButton<String>(
                  value: _portionDropdown,
                  icon: const Icon(Icons.access_time, color: Colors.white),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black45
                  ),
                  underline: Container(
                    height: 1.5,
                    color: Colors.black38,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _portionDropdown = newValue!;
                      _onSearchChanged();
                    });
                  },
                  items: <List>[['all', 'all'],['less than 30 min', '1' ],['in 30-60 min', '2'], ['in 60-90 min', '3'], ['more than 90 min', '4']]
                      .map<DropdownMenuItem<String>>((List item) {
                    return DropdownMenuItem<String>(
                      value: item[1],
                      child: Text(item[0]),
                    );
                  })
                      .toList(),
                ),
                DropdownButton<String>(
                  value: _originDropdown,
                  icon: const Icon(
                      Icons.tonality,
                      color: Colors.white
                  ),
                  iconSize: 26,
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.black45
                  ),
                  underline: Container(
                    height: 1.5,
                    color: Colors.black38,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _originDropdown = newValue!;
                      _onSearchChanged();
                    });
                  },
                  items: _allOrigins
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                      .toList(),
                ),
              ],
            ),
          ),
          OutlinedButton(
            child: Text('Clear filters'),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.black38,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onPressed: () {
              _onSearchCleared();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) => Stack(
                children: [
                  RecipeCard(
                    recipe: Recipe.convertDocument(_resultsList[index]),
                  ),
                  Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showDetailScreen(context, Recipe.convertDocument(_resultsList[index])),
                        ),
                      ))
                ],
              ),
            )
          )
        ],
      )
    );
  }
}