import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = "Color Picker";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Color> _colors = {
    "purple": Colors.purple,
    "blue": Colors.blue,
    "teal": Colors.teal,
    "yellow": Colors.yellow,
    "orange": Colors.orange,
    "pink": Colors.pink,
  };

  Color? selectedColor;

  @override
  void initState() {
    _getStoredColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: selectedColor ?? Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "You are operating on ${Platform.operatingSystem}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          for (var color in _colors.entries)
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: color.value, minimumSize: Size(300, 60)),
                child: Text(color.key),
                onPressed: () => _setColor(color.key, color.value),
              ),
            )
        ],
      ),
    );
  }

  Future<void> _setColor(String colorName, Color color) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString("color", colorName);
    setState(() {
      selectedColor = color;
    });
  }

  Future<void> _getStoredColor() async {
    var preferences = await SharedPreferences.getInstance();
    var colorName = preferences.getString("color");
    setState(() {
      selectedColor = _colors[colorName];
    });
  }
}
