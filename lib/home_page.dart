import 'package:devtools_app/screens/data_preparing/data_preparing.dart';
import 'package:devtools_app/screens/magic.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: const [
      DataPreparing(),
      Magic(),
    ]);
  }
}
