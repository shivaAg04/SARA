import 'package:flutter/material.dart';

import 'categories_button.dart';

class CategooryRow extends StatelessWidget {
  const CategooryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 143, 255, 147),
              chooseIcon: "book",
              chooseText: "Quantum"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 255, 90, 241),
              chooseIcon: "air-cooler",
              chooseText: "Coolers"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 117, 244, 255),
              chooseIcon: "lab-coat",
              chooseText: "Lab Coat"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 103, 108, 255),
              chooseIcon: "budget",
              chooseText: "Calculators"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 255, 252, 85),
              chooseIcon: "sports",
              chooseText: "Sports"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 255, 0, 234),
              chooseIcon: "stationary",
              chooseText: "Stationary"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 46, 222, 72),
              chooseIcon: "electrical",
              chooseText: "Electrical"),
          CategoriesButton(
              chooseColor: Color.fromARGB(255, 255, 188, 2),
              chooseIcon: "option",
              chooseText: "Others"),
        ],
      ),
    );
  }
}
