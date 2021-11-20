import 'package:flutter/material.dart';

class ResultBox extends StatefulWidget {
  const ResultBox({Key? key}) : super(key: key);

  @override
  _ResultBoxState createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์ -----'),
      ),
    );
  }
}
