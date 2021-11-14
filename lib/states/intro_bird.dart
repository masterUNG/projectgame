import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project_game/model/show_title.dart';
import 'package:project_game/utility/my_constant.dart';
import 'package:project_game/widgets/show_progress.dart';

class Introbird extends StatefulWidget {
  const Introbird({Key? key}) : super(key: key);

  @override
  _IntrobirdState createState() => _IntrobirdState();
}

class _IntrobirdState extends State<Introbird> {
  List<String> images = [
    'asset/images/image1.png',
    'asset/images/image2.png',
    'asset/images/image1.png',
  ];
  List<String> titles = [
    'title1',
    'title2',
    'title3',
  ];
  List<String> bodys = [
    'body1',
    'body2',
    'body3',
  ];
  List<PageViewModel> pageViewModels = [];

  @override
  void initState() {
    super.initState();
    int index = 0;
    for (var item in titles) {
      setState(() {
        pageViewModels.add(
          createPageViewModel(
            item,
            bodys[index],
            images[index],
          ),
        );
      });
    }
  }

  PageViewModel createPageViewModel(
    String title,
    String body,
    String pathImage,
  ) =>
      PageViewModel(
        titleWidget: ShowTitle(
          title: title,
          textStyle: MyConstant().h1Style(),
        ),
        body: body,
        image: Container(
          width: 200,
          height: 200,
          child: Image.asset(pathImage),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แนะนำเกม'),
      ),
      body: pageViewModels.isEmpty
          ? ShowProgress()
          : IntroductionScreen(
              pages: pageViewModels,
              onDone: () => Navigator.pushNamedAndRemoveUntil(context, MyConstant.routeCountTime, (route) => false),
              done: Icon(Icons.forward),
              skip: ShowTitle(
                title: 'Skip',
                textStyle: MyConstant().h3Style(),
              ),
                showSkipButton: true,
                showNextButton: true,
                next: Icon(Icons.forward),
            ),
    );
  }
}
