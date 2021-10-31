import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_game/model/profile.dart';
import 'package:project_game/pageAuth/home.dart';

class pageMenu extends StatefulWidget {
  @override
  _pageMenuState createState() => _pageMenuState();
}

class _pageMenuState extends State<pageMenu> {
  final auth = FirebaseAuth.instance;
  Profile profile =
      Profile(email: '', password: '', age: '', name: '', urlProfile: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลส่วนตัว"),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
