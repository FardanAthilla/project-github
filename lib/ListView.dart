import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: ViewList(),
    );
  }
}

class ViewList extends StatefulWidget {
  @override
  _ViewListState createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
      ),
      body: ListView.builder(
        itemCount: 21,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            subtitle: Text('Subtitle for Item $index'),
            leading: Icon(Icons.home),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tapp on index $index'),
                  duration: Duration(seconds: 1),
                  backgroundColor: Color.alphaBlend(Color.fromARGB(255, 0, 0, 0), Colors.greenAccent),
                ));
            },
          );
        },
      ),
    );
  }
}