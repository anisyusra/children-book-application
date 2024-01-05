import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Question ${indexAction + 1}/$totalQuestions:',
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '$question',
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
