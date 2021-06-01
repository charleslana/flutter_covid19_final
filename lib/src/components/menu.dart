import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff37b8ae),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.public, size: 40.0),
          Icon(Icons.place, size: 40.0),
          Icon(Icons.analytics, size: 40.0),
          Icon(Icons.warning, size: 40.0),
          Icon(Icons.favorite, size: 40.0),
          Icon(Icons.medication, size: 40.0),
        ],
      ),
    );
  }
}
