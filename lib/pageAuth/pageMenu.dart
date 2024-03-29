import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_game/model/profile.dart';
import 'package:project_game/model/show_title.dart';
import 'package:project_game/model/user_model.dart';
import 'package:project_game/pageAuth/home.dart';
import 'package:project_game/utility/my_constant.dart';
import 'package:project_game/widgets/show_image.dart';
import 'package:project_game/widgets/show_navigator.dart';
import 'package:project_game/widgets/show_progress.dart';

class PageMenu extends StatefulWidget {
  @override
  _PageMenuState createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  UserModel? userModel;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    findProfile();
  }

  Future<void> findProfile() async {
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uid = event!.uid;
      print('## uid = $uid');
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .get()
          .then((value) {
        setState(() {
          userModel = UserModel.fromMap(value.data()!);
        });
      });
    });
  }

  final auth = FirebaseAuth.instance;
  Profile profile =
      Profile(email: '', password: '', age: '', name: '', urlProfile: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: userModel == null
          ? ShowProgress()
          : Center(
              child: Column(
                children: [
                  buildImage(),
                  buildName(),
                  ShowNavigator(
                      iconData: Icons.filter_1,
                      label: 'bird counting',
                      routeState: MyConstant.routeIntroBird),
                  ShowNavigator(
                      iconData: Icons.filter_2,
                      label: 'box counting',
                      routeState: MyConstant.routeIntroBox),
                      ShowNavigator(
                      iconData: Icons.filter_3,
                      label: 'flag Raising',
                      routeState: MyConstant.routeIntroBox),
                ],
              ),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("หน้าหลัก"),
      actions: [
        IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              });
            },
            icon: Icon(
              Icons.logout,
              size: 40,
              color: Colors.white,
            ))
      ],
    );
  }

  Container buildImage() {
    return Container(
      width: 150,
      height: 150,
      child: ShowImage(partUrl: userModel!.urlProfile),
    );
  }

  ShowTitle buildName() {
    return ShowTitle(
      title: userModel!.name,
      textStyle: MyConstant().h1Style(),
    );
  }
}
