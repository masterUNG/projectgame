import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_game/pageAuth/home.dart';
import 'package:project_game/pageAuth/pageMenu.dart';
import 'package:project_game/states/count_timebird.dart';
import 'package:project_game/states/count_timebox.dart';
import 'package:project_game/states/count_timeflagraising.dart';
import 'package:project_game/states/game_bird.dart';
import 'package:project_game/states/game_box.dart';
import 'package:project_game/states/game_flagraising.dart';
import 'package:project_game/states/intro_bird.dart';
import 'package:project_game/states/intro_box.dart';
import 'package:project_game/states/intro_flagraising.dart';
import 'package:project_game/states/result_bird.dart';
import 'package:project_game/states/result_box.dart';
import 'package:project_game/states/result_flagraising.dart';
import 'package:project_game/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeHome: (BuildContext context) => HomeScreen(),
  MyConstant.routePagemenu: (BuildContext context) => PageMenu(),
  MyConstant.routeIntroBird: (BuildContext context) => IntroBird(),
  MyConstant.routeCountTimeBird: (BuildContext context) => CountTimeBird(),
  MyConstant.routeGameBird: (BuildContext context) => GameBird(),
  MyConstant.routeResultBird: (BuildContext context) => ResultBird(),
  MyConstant.routeIntroBox: (BuildContext context) => IntroBox(),
  MyConstant.routeCountTimeBox: (BuildContext context) => CountTimeBox(),
  MyConstant.routeGameBox: (BuildContext context) => GameBox(),
  MyConstant.routeResultBox: (BuildContext context) => ResultBox(),
  MyConstant.routeIntroFlagraising: (BuildContext context) => IntroFlagraising(),
  MyConstant.routeCountTimeFlagraising: (BuildContext context) => CountTimeFlagraising(),
  MyConstant.routeGameFlagraising: (BuildContext context) => GameFlagraising(),
  MyConstant.routeResultFlagraising: (BuildContext context) => ResultFlagraising(),
};

String? firstState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        firstState = MyConstant.routeHome;
        runApp(MyApp());
      } else {
        firstState = MyConstant.routePagemenu;
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: map,
      initialRoute: firstState,
    );
  }
}
