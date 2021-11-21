import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_game/model/score_model.dart';
import 'package:project_game/widgets/show_progress.dart';

class ResultBird extends StatefulWidget {
  const ResultBird({Key? key}) : super(key: key);

  @override
  _ResultBirdState createState() => _ResultBirdState();
}

class _ResultBirdState extends State<ResultBird> {
  List<ScoreModel> scoreModels = [];
  late String uid;

  // List<Series<dynamic, dynamic> listSeries = [];

  var series;
  List<int> times = [];

  @override
  void initState() {
    super.initState();
    findUidUser();
  }

  Future<void> findUidUser() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('scorebird')
          .get()
          .then((value) {
            int i = 0;
        for (var item in value.docs) {
          ScoreModel model = ScoreModel.fromMap(item.data());
          setState(() {
            scoreModels.add(model);
            times.add(i);
            i++;
          });
        }

        series = Series(
          id: 'id',
          data: scoreModels,
          domainFn: (ScoreModel scoreModel, index) => scoreModel.playTime,
          measureFn: (ScoreModel scoreModel, index) => scoreModel.score,
        );
        // listSeries.add(series);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์ -----'),
      ),
      body: scoreModels.isEmpty
          ? ShowProgress()
          : LineChart([series]),
    );
  }
}
