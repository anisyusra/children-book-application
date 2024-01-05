import 'package:flutter/material.dart';
import '../../constants/image_string.dart';
import '../../models/maths/maths_quest.dart';

class MathsBox extends StatelessWidget {
  const MathsBox({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                          color: Colors.grey)
                    ],
                    gradient:
                        const LinearGradient(begin: Alignment.topLeft, colors: [
                      Color.fromARGB(255, 136, 8, 53),
                      Color.fromARGB(255, 226, 129, 210),
                    ]),
                    border:
                        Border.all(color: const Color.fromARGB(255, 239, 178, 228)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 120,
                  width: width * 0.83,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 15,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MathGame()),
                            );
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        const Text(
                          "Mathematics",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "The abstract science of number, quantity, and space.",
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 30,
            top: 8,
            child: Container(
              child: Image(
                image: const AssetImage(maths),
                height: height * 0.1,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MathGame()),
        );
      },
    );
  }
}
