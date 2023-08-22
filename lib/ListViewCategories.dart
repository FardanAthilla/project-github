import 'package:flutter/material.dart';
import 'GridViewCategory.dart';
import 'api.dart';

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
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
            return listData(snapshot);
          }
        },
      ),
    );
  }

  listData(snapshot) {
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
}
