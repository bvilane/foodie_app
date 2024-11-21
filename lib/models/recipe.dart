class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtubeUrl;
  final List<String> ingredients;
  final List<String> measurements;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtubeUrl,
    required this.ingredients,
    required this.measurements,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> getIngredients(Map<String, dynamic> json) {
      List<String> ingredients = [];
      for (int i = 1; i <= 20; i++) {
        String? ingredient = json['strIngredient$i'];
        if (ingredient != null && ingredient.trim().isNotEmpty) {
          ingredients.add(ingredient.trim());
        }
      }
      return ingredients;
    }

    List<String> getMeasurements(Map<String, dynamic> json) {
      List<String> measurements = [];
      for (int i = 1; i <= 20; i++) {
        String? measurement = json['strMeasure$i'];
        if (measurement != null && measurement.trim().isNotEmpty) {
          measurements.add(measurement.trim());
        }
      }
      return measurements;
    }

    return Recipe(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: getIngredients(json),
      measurements: getMeasurements(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strCategory': category,
      'strArea': area,
      'strInstructions': instructions,
      'strMealThumb': thumbnail,
      'strYoutube': youtubeUrl,
      ...Map.fromIterables(
        List.generate(20, (i) => 'strIngredient${i + 1}'),
        List.generate(20, (i) => i < ingredients.length ? ingredients[i] : ''),
      ),
      ...Map.fromIterables(
        List.generate(20, (i) => 'strMeasure${i + 1}'),
        List.generate(20, (i) => i < measurements.length ? measurements[i] : ''),
      ),
    };
  }
}