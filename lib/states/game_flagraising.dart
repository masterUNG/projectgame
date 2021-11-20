import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_game/model/bird_model.dart';
import 'package:project_game/model/show_title.dart';
import 'package:project_game/utility/my_constant.dart';
import 'package:project_game/widgets/show_image.dart';
import 'package:project_game/widgets/show_progress.dart';
import 'package:sensors/sensors.dart';

class GameFlagraising extends StatefulWidget {
  const GameFlagraising({Key? key}) : super(key: key);

  @override
  _GameFlagraisingState createState() => _GameFlagraisingState();
}

class _GameFlagraisingState extends State<GameFlagraising> {
  int timeflag = 0, myAnswer = 0, score = 0, playTime = 0, timeStop = 0;
  double x = 0, y = 0, z = 0;
  List<int> idQuestions = [];
  List<BirdModel> flagModels = [];

  @override
  void initState() {
    super.initState();
    randomQuestion();
    autoPlayTime();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  Future<void> autoPlayTime() async {
    Duration duration = Duration(seconds: 1);
    // ignore: await_only_futures
    await Timer(duration, () {
      setState(() {
        playTime++;
      });
      autoPlayTime();
    });
  }

  Future<void> randomQuestion() async {
    for (var i = 0; i < 5; i++) {
      int i = Random().nextInt(4);
      idQuestions.add(i);

      await FirebaseFirestore.instance
          .collection('flag')
          .doc('doc$i')
          .get()
          .then((value) {
        BirdModel model = BirdModel.fromMap(
          value.data()!,
        );
        setState(() {
          flagModels.add(model);
        });
      });
    }
    print('## $idQuestions');
  }

  @override
  Widget build(BuildContext context) {
    if (x >= -2 && x <= 2 && y >= 8 && y <= 10 && z >= -2 && z <= 2) {
      setState(() {
        myAnswer = 1;
      });
    } else if (x >= 8 && x <= 10 && y >= -2 && y <= 2 && z >= -2 && z <= 2) {
      setState(() {
        myAnswer = 2;
      });
    } else if (x <= -8 && x >= -10 && y >= -2 && y <= 2 && z >= -2 && z <= 2) {
      setState(() {
        myAnswer = 3;
      });
    } else {
      setState(() {
        myAnswer = 0;
      });
    }
    processCalculate();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flagraising Counting Game'),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$playTime sec'),
              ),
            ],
          )
        ],
      ),
      body: flagModels.isEmpty
          ? ShowProgress()
          : Center(
              child: Column(
                children: [
                  buildImage(),
                  buildMyAnswer(),
                ],
              ),
            ),
    );
  }

  ShowTitle buildMyAnswer() =>
      ShowTitle(title: myAnswer.toString(), textStyle: MyConstant().h0Style());

  Container buildImage() {
    return Container(
      width: 350,
      height: 350,
      child: ShowImage(partUrl: flagModels[timeflag].path),
    );
  }

  void processCalculate() {
    if (timeflag == 5) {
      if (myAnswer == flagModels[timeflag].answer) {
        score++;
      }
      print('## $score');
      timeStop = playTime;
      print('## $timeStop');
      Navigator.pushNamedAndRemoveUntil(
          context, MyConstant.routeResultBox, (route) => false);
    } else {
      if (myAnswer == flagModels[timeflag].answer) {
        score++;
        setState(() {
        myAnswer = 0;
        timeflag++;
      });
      }
      print('## $score');
    }
  }
}
