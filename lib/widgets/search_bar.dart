import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 50,
        child: Container(
          width: double.infinity,
          color: Colors.yellow,
          child: const Center(
            child: Text(
              "Search BOx",
              style: TextStyle(fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}
