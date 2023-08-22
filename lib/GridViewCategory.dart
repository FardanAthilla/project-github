import 'package:flutter/material.dart';
import 'api.dart';

class GridViewCategory extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  GridViewCategory({required this.categoryId, required this.categoryName});

  @override
  _GridViewCategoryState createState() => _GridViewCategoryState();
}

class _GridViewCategoryState extends State<GridViewCategory> {
  Future<List<Meal>> getMeals() async {
    return fetchMealsByCategory(widget.categoryName);
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
            return listData(snapshot);
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  listData(snapshot) {
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
  }
}
