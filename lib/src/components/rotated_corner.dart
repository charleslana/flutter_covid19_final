import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class RotatedCorner extends StatelessWidget {
  final BadgeAlignment alignment;
  final double sizeWidth;
  final double sizeHeight;
  final int color;

  const RotatedCorner({
    Key? key,
    required this.alignment,
    required this.sizeWidth,
    required this.sizeHeight,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: RotatedCornerDecoration(
        color: Color(color),
        geometry: BadgeGeometry(
          width: sizeWidth,
          height: sizeHeight,
          alignment: alignment,
        ),
      ),
    );
  }
}
