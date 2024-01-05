import 'package:flutter/material.dart';

import 'box/alpha_box.dart';
import 'box/animals_box.dart';
import 'box/maths_box.dart';
import 'box/transport_box.dart';
import 'box/value_box.dart';


class BoxList extends StatelessWidget {
  const BoxList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueBox(),
          SizedBox(
            height: 30,
          ),
          TransBox(),
          SizedBox(
            height: 30,
          ),
          AlphaBox(),
          SizedBox(
            height: 30,
          ),
          AnimalsBox(),
          SizedBox(
            height: 30,
          ),
          MathsBox(),
        ],
      ),
    );
  }
}
