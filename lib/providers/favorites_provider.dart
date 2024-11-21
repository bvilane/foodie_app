import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};
  final List<Recipe> _favorites = [];
  static const String _prefsKey = 'favorite_recipes';

  FavoritesProvider() {
    _loadFavorites();
  }

  List<Recipe> get favorites => _favorites;

  bool isFavorite(String recipeId) => _favoriteIds.contains(recipeId);

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_prefsKey) ?? [];

    _favorites.clear();
    _favoriteIds.clear();

    for (var jsonString in favoritesJson) {
      try {
        Map<String, dynamic> json = jsonDecode(jsonString);
        Recipe recipe = Recipe.fromJson(json);
        _favorites.add(recipe);
        _favoriteIds.add(recipe.id);
      } catch (e) {
        debugPrint('Error loading favorite: $e');
      }
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favorites.map((recipe) =>
        jsonEncode(recipe.toJson())
    ).toList();
    await prefs.setStringList(_prefsKey, favoritesJson);
  }

  Future<void> toggleFavorite(Recipe recipe) async {
    final isCurrentlyFavorite = _favoriteIds.contains(recipe.id);

    if (isCurrentlyFavorite) {
      _favoriteIds.remove(recipe.id);
      _favorites.removeWhere((r) => r.id == recipe.id);
    } else {
      _favoriteIds.add(recipe.id);
      _favorites.add(recipe);
    }

    await _saveFavorites();
    notifyListeners();
  }
}