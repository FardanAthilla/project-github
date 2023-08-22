import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String thumbnail;

  Category({required this.id, required this.name, required this.thumbnail});
}

Future<List<Category>> getCategoryList() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> categoriesData = data['categories'];

    List<Category> categories = categoriesData.map((categoryData) {
      return Category(
        id: categoryData['idCategory'],
        name: categoryData['strCategory'],
        thumbnail: categoryData['strCategoryThumb'],
      );
    }).toList();

    return categories;
  } else {
    throw Exception('Failed to fetch categories');
  }
}

class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({required this.id, required this.name, required this.thumbnail});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
    );
  }
}

Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
  final response = await http.get(Uri.parse(
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> mealsData = data['meals'];

    List<Meal> meals = mealsData.map((mealData) {
      return Meal(
        id: mealData['idMeal'],
        name: mealData['strMeal'],
        thumbnail: mealData['strMealThumb'],
      );
    }).toList();

    return meals;
  } else {
    throw Exception('Failed to fetch data');
  }
}