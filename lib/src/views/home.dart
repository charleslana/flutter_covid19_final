import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/grid_option_card.dart';
import 'package:flutter_covid19_final/src/components/rotated_corner.dart';
import 'package:flutter_covid19_final/src/data/data_home.dart';
import 'package:flutter_covid19_final/src/models/grid_home.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class Home extends StatelessWidget {
  final Map<String, GridHome> _options = {...DATA_HOME};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotatedCorner(
          alignment: BadgeAlignment.topRight,
          sizeWidth: 200,
          sizeHeight: 200,
        ),
        RotatedCorner(
          alignment: BadgeAlignment.bottomLeft,
          sizeWidth: 100,
          sizeHeight: 100,
        ),
        Container(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            children: List.generate(
              _options.length,
              (index) {
                return Center(
                  child:
                      GridOptionCard(option: _options.values.elementAt(index)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
