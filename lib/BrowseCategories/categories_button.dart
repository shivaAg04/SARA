// import 'dart:html';

import 'package:flutter/material.dart';

import 'browse_products_coulmn.dart';

class CategoriesButton extends StatelessWidget {
  Color? chooseColor;
  String? chooseIcon;
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => BrowswProductColumn(chooseText!)),
            ));
      },
      child: Container(
        height: 90,
        width: 100,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 35,
              backgroundColor: chooseColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/icon/icons/$chooseIcon.png"),
              ),
            ),
            Spacer(),
            Text(
              chooseText!,
              style: TextStyle(
                color: Color.fromARGB(255, 1, 85, 129),
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
