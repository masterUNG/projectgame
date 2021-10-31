import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_game/model/profile.dart';
import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile =
      Profile(email: '', password: '', age: '', name: '', urlProfile: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  final auth = FirebaseAuth.instance;
  // ignore: avoid_init_to_null
  File? myFile;

  @override
  Widget showImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: new SizedBox(
              width: 130,
              height: 130,
              child: myFile == null
                  ? Image.asset(
                      'asset/images/123.png',
                      fit: BoxFit.cover,
                    )
                  : Image.file(myFile!, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('User/user$i.jpg');
    UploadTask uploadTask = reference.putFile(myFile!);
    profile.urlProfile =
        await uploadTask.then((res) => res.ref.getDownloadURL());
    print('####################### ${profile.urlProfile}');
  }

  Future<void> selectImg(ImageSource imageSource) async {
    var myImg = await ImagePicker()
        .pickImage(source: imageSource, maxHeight: 500, maxWidth: 500);
    setState(() {
      myFile = File(myImg!.path);
    });
  }

  Widget shoeButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              selectImg(ImageSource.camera);
            },
            icon: Icon(
              Icons.add_a_photo,
              size: 40,
              color: Colors.purple,
            )),
        IconButton(
            onPressed: () {
              selectImg(ImageSource.gallery);
            },
            icon: Icon(
              Icons.add_photo_alternate,
              size: 40,
              color: Colors.purple,
            )),
        ElevatedButton(
            onPressed: () {
              uploadPictureToStorage();
            },
            child: Text('ยืนยัน'),style: ElevatedButton.styleFrom(primary: Colors.amber,
            ),)
      ],
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("สร้างบัญชีผู้ใช้"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showImage(),
                          shoeButton(),
                          Text("อีเมล", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password!;
                            },
                          ),
                          Text("ชื่อ", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนชื่อด้วยครับ"),
                            onSaved: (String? name) {
                              profile.name = name!;
                            },
                          ),
                          Text("อายุ", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนอายุด้วยครับ"),
                            keyboardType: TextInputType.number,
                            onSaved: (String? age) {
                              profile.age = age!;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("ลงทะเบียน",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      user.doc(auth.currentUser!.uid).set({
                                        'name': profile.name,
                                        'age': double.parse(profile.age),
                                        'urlProfile': profile.urlProfile,
                                      });
                                      Fluttertoast.showToast(
                                          msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                          gravity: ToastGravity.TOP);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    String message;
                                    if (e.code == 'email-already-in-use') {
                                      message =
                                          "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                    } else if (e.code == 'weak-password') {
                                      message =
                                          "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                    } else {
                                      message = e.message!;
                                    }
                                    Fluttertoast.showToast(
                                        msg: message,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
