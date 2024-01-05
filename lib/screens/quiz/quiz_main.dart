import 'package:flutter/material.dart';
import 'package:project_mobile/constants/colors.dart';
import 'package:project_mobile/screens/homepage/home_screen.dart';

import '../../common_widgets/box_list.dart';
import '../../common_widgets/header_main.dart';


class QuizMain extends StatefulWidget {
  const QuizMain({
    Key? key,
  }) : super(key: key);

  @override
  State<QuizMain> createState() => _QuizMainState();
}

class _QuizMainState extends State<QuizMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: tPrimaryColor,
            appBar: AppBar(
              backgroundColor: tPrimaryColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                icon: const Icon(Icons.home),
                iconSize: 25,
                color: Colors.white,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Column(children: [
                    Row(
                      children: [
                        HeaderMain(),
                      ],
                    ),
                    BoxList(),
                  ])),
            )));
  }
}
