// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kiet_olx/screens/home/category_screen.dart';

class CategoriesButton extends StatelessWidget {
  Color? chooseColor;
  Icon? chooseIcon;
  String? chooseText;
  CategoriesButton(
      {Key? key,
      required this.chooseColor,
      required this.chooseIcon,
      required this.chooseText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => CategoryScreen())));
      },
      child: Container(
        height: 100,
        width: 100,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 35,
              child: chooseIcon,
              backgroundColor: chooseColor,
            ),
            Spacer(),
            Text(
              chooseText!,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
