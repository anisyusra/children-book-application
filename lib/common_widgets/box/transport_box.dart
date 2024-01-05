import 'package:flutter/material.dart';
import '../../constants/image_string.dart';
import '../../models/transporation/transport_quest.dart';

class TransBox extends StatelessWidget {
  const TransBox({super.key});

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
                      Color.fromARGB(255, 124, 46, 249),
                      Color.fromARGB(255, 237, 163, 224),
                    ]),
                    border:
                        Border.all(color: const Color.fromARGB(255, 227, 178, 239)),
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
                              MaterialPageRoute(builder: (context) =>const TransportGame()),
                            );
                          },
                          icon: const Icon(Icons.play_circle_outline),
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        const Text(
                          "Transport",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "business of moving people using vehicles.",
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
            top: 10,
            child: Container(
              child: Image(
                image: const AssetImage(transport),
                height: height * 0.12,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransportGame()),
        );
      },
    );
  }
}
