import 'package:flutter/material.dart';
import 'package:project_mobile/constants/colors.dart';

import '../screens/quiz/quiz_main.dart';
import 'game_color.dart';

class ResultBox extends StatefulWidget {
  ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,

    // required this.onPressed,
  }) : super(key: key);
  final int result;
  final int questionLength;

  @override
  State<ResultBox> createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> {
  // final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: tPrimaryColor,
      content: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TOTAL SCORE',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(2, 84, 100, 1)),
            ),
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: widget.result == widget.questionLength / 2
                  ? const Color.fromARGB(
                      255, 255, 147, 59) //when result half of total quest
                  : widget.result < widget.questionLength / 2
                      ? incorrect //when result less than half
                      : correct,
              child: Text(
                '${widget.result}/${widget.questionLength}',
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ), //when result more than half
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.result == widget.questionLength / 2
                  ? 'Almost There' //when result half of total quest
                  : widget.result < widget.questionLength / 2
                      ? 'Dont Give Up' //when result less than half
                      : 'Excellent!', //when result more than half
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(229, 124, 35, 1)),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizMain()),
                    );
                  },
                  icon: const Icon(Icons.home),
                  iconSize: 40,
                  color: const Color.fromRGBO(232, 170, 66, 1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// void saveResultData(
//   int result,
//   int questionLength,
// ) async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     String uid = user.uid;

//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//           .instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('quiz')
//           .doc(user.uid)
//           .get();

//       int existingPoints = snapshot.exists ? snapshot.data()!['points'] : 0;
//       int points = ((result / questionLength) * 100).round();
//       int totalPoints = existingPoints + points;

//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .collection('quiz')
//           .doc(user.uid)
//           .set({
//         'score': result,
//         'questionLength': questionLength,
//         'points': totalPoints,
//         'timestamp': DateTime.now(),
//       });
//       SetOptions(merge: true);
//     } catch (error) {
//       print('Error saving result data: $error');
//     }
//   } else {
//     print('User is not authenticated');
//   }
// }
