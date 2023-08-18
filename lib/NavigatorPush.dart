import 'package:flutter/material.dart';
import 'package:project_github/ListViewCategories.dart';

class NavigatorPush extends StatefulWidget {
  const NavigatorPush({Key? key});

  @override
  State<NavigatorPush> createState() => _NavigatorPush();
}

class _NavigatorPush extends State<NavigatorPush> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return ViewList();
            }));
          },
          child: Text(
            'List Meals',
            style: TextStyle(color: const Color.fromARGB(255, 206, 202, 202)),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF263246)),
          ),
        ),
      ),
    );
  }
}