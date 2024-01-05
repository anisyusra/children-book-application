import 'package:flutter/material.dart';

class HeaderMain extends StatelessWidget {
  const HeaderMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Let's Play",
          style: TextStyle(
              fontFamily: "RubixPixels",
              color: Colors.pinkAccent,
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Get a full mark!",
          style: TextStyle(
              color: Color.fromARGB(255, 98, 7, 37),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
