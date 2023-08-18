import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class GridViewCategory extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  GridViewCategory({required this.categoryId, required this.categoryName});

  @override
  _GridViewCategoryState createState() => _GridViewCategoryState();
}

class _GridViewCategoryState extends State<GridViewCategory> {
  Future<List<Meal>> getMeals() async {
    final response = await http.get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.categoryName}'));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals in ${widget.categoryName}'),
      ),
      body: FutureBuilder<List<Meal>>(
        future: getMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.network(
                            snapshot.data![index].thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        snapshot.data![index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
