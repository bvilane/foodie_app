import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../widgets/recipe_card.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_grid.dart';

class RecipeListScreen extends StatefulWidget {
  final String category;

  const RecipeListScreen({
    super.key,
    required this.category,
  });

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = _apiService.getRecipesByCategory(widget.category);
  }

  Future<void> _refreshRecipes() async {
    setState(() {
      _recipesFuture = _apiService.getRecipesByCategory(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshRecipes,
        child: FutureBuilder<List<Recipe>>(
          future: _recipesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingGrid();
            } else if (snapshot.hasError) {
              return ErrorView(
                error: snapshot.error.toString(),
                onRetry: _refreshRecipes,
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No recipes found'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recipe = snapshot.data![index];
                return RecipeCard(recipe: recipe);
              },
            );
          },
        ),
      ),
    );
  }
}