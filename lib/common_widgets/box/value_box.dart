import 'package:flutter/material.dart';
import '../../constants/image_string.dart';
import '../../models/value/value_quest.dart';

class ValueBox extends StatelessWidget {
  const ValueBox({super.key});

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
                      Color.fromARGB(255, 46, 127, 249),
                      Color.fromARGB(255, 60, 189, 235),
                    ]),
                    border:
                        Border.all(color: const Color.fromARGB(255, 180, 225, 244)),
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
                              MaterialPageRoute(
                                  builder: (context) => const ValueGame()),
                            );
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        const Text(
                          "Values",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "The Principles that help you to decide what is right and wrong.",
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
            top: -5,
            child: Container(
              child: Image(
                image: const AssetImage(value),
                height: height * 0.12,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ValueGame()),
        );
      },
    );
  }
}
