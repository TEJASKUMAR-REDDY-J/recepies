import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.api.dart';
import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe>? _recipes;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      _recipes = await RecipeApi.getRecipe();
      setState(() {
        _isLoading = false;
      });
      print(_recipes);
    } catch (e) {
      print("Error fetching recipes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Recipes'),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _recipes != null
              ? ListView.builder(
                  itemCount: _recipes!.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      title: _recipes![index].name,
                      cookTime: _recipes![index].totalTime,
                      rating: _recipes![index].rating.toString(),
                      thumbnailUrl: _recipes![index].images, // Provide a default value or handle it as needed
                    );
                  },
                )
              : Center(
                  child: Text('No recipes found.'),
                ),
    );
  }
}
