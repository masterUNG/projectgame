import 'package:flutter/material.dart';

class ResultBird extends StatefulWidget {
  const ResultBird({Key? key}) : super(key: key);

  @override
  _ResultBirdState createState() => _ResultBirdState();
}

class _ResultBirdState extends State<ResultBird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์ -----'),
      ),
    );
  }
}
