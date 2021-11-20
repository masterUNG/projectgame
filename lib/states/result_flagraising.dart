import 'package:flutter/material.dart';

class ResultFlagraising extends StatefulWidget {
  const ResultFlagraising({Key? key}) : super(key: key);

  @override
  _ResultFlagraisingState createState() => _ResultFlagraisingState();
}

class _ResultFlagraisingState extends State<ResultFlagraising> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์ -----'),
      ),
    );
  }
}
