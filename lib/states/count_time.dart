import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_game/model/show_title.dart';
import 'package:project_game/utility/my_constant.dart';

class CountTime extends StatefulWidget {
  const CountTime({Key? key}) : super(key: key);

  @override
  _CountTimeState createState() => _CountTimeState();
}

class _CountTimeState extends State<CountTime> {
  int count = 3;

  @override
  void initState() {
    super.initState();
    autoCount();
  }

  Future<void> autoCount() async {
    Duration duration = Duration(seconds: 1);
    await Timer(duration, () {
      if (count == 0) {
        Navigator.pushNamedAndRemoveUntil(
            context, MyConstant.routeGameBird, (route) => false);
      } else {
        setState(() {
          count--;
        });
        autoCount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShowTitle(
          title: count.toString(),
          textStyle: MyConstant().h0Style(),
        ),
      ),
    );
  }
}
