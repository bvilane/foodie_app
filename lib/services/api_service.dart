import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> categories = data['categories'];
        return categories.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<List<Recipe>> getRecipesByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/filter.php?c=$category'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'] ?? [];
        List<Recipe> recipes = [];

        for (var meal in meals) {
          final recipeDetails = await getRecipeDetails(meal['idMeal']);
          if (recipeDetails != null) {
            recipes.add(recipeDetails);
          }
        }

        return recipes;
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }

  Future<Recipe?> getRecipeDetails(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/lookup.php?i=$id'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          return Recipe.fromJson(data['meals'][0]);
        }
        return null;
      } else {
        throw Exception('Failed to load recipe details');
      }
    } catch (e) {
      throw Exception('Error fetching recipe details: $e');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?s=${Uri.encodeComponent(query)}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> meals = data['meals'] ?? [];
        return meals.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search recipes');
      }
    } catch (e) {
      throw Exception('Error searching recipes: $e');
    }
  }
}