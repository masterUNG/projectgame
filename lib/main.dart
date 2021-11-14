import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_game/pageAuth/home.dart';
import 'package:project_game/pageAuth/pageMenu.dart';
import 'package:project_game/states/count_time.dart';
import 'package:project_game/states/game_bird.dart';
import 'package:project_game/states/intro_bird.dart';
import 'package:project_game/states/result_bird.dart';
import 'package:project_game/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeHome: (BuildContext context) => HomeScreen(),
  MyConstant.routePagemenu: (BuildContext context) => PageMenu(),
  MyConstant.routeIntroBird: (BuildContext context) => Introbird(),
  MyConstant.routeCountTime: (BuildContext context) => CountTime(),
  MyConstant.routeGameBird: (BuildContext context) => GameBird(),
  MyConstant.routeResultBird: (BuildContext context) => ResultBird(),
};

String? firstState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
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
