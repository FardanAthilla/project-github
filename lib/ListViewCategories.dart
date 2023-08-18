import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Tambahkan import ini
import 'GridViewCategory.dart';

class Category {
  final String id;
  final String name;
  final String thumbnail;

  Category({required this.id, required this.name, required this.thumbnail});
}

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  Future<List<Category>> getCategoryList() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Category'),
      ),
      body: FutureBuilder<List<Category>>(
        future: getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].thumbnail),
                  ),
                  title: Text(snapshot.data![index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridViewCategory(
                          categoryId: snapshot.data![index].id,
                          categoryName: snapshot.data![index].name,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
