import 'package:flutter/material.dart';
import 'package:project_mobile/constants/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: tPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Text(
          'Next Question',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ));
  }
}
