import 'package:flutter/material.dart';
import 'package:project_github/ListView.dart';

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
      appBar: AppBar(
        title: Text('NavigatorPush'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), 
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ViewList();
            }));
          },
          child: Text(
            'Masuk',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF263246)), // Atur warna tombol "Log Out"
          ),
        ),
      ),
    );
  }
}