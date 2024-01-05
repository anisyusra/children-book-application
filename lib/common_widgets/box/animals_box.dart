import 'package:flutter/material.dart';
import '../../constants/image_string.dart';
import '../../models/animal/animal_quest.dart';

class AnimalsBox extends StatelessWidget {
  const AnimalsBox({super.key});

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
                      Color.fromARGB(255, 11, 136, 8),
                      Color.fromARGB(255, 145, 237, 105),
                    ]),
                    border:
                        Border.all(color: const Color.fromARGB(255, 239, 229, 178)),
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
                              MaterialPageRoute(builder: (context) => const AnimalGame()),
                            );
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        const Text(
                          "Animals",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Aliving organism that feeds on organic matter.",
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
                image: const AssetImage(animals),
                height: height * 0.1,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimalGame()),
        );
      },
    );
  }
}
