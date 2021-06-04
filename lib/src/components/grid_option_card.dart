import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/models/grid_home.dart';

class GridOptionCard extends StatelessWidget {
  final GridHome option;
  const GridOptionCard({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color(option.backgroundColor),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(option.route),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  option.pathImage,
                  fit: BoxFit.contain,
                  height: 100,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      option.title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(option.color),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
