import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class RotatedCorner extends StatelessWidget {
  final BadgeAlignment alignment;
  final double sizeWidth;
  final double sizeHeight;

  const RotatedCorner(
      {required this.alignment,
      required this.sizeWidth,
      required this.sizeHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: RotatedCornerDecoration(
        color: Color(0xff65c1bd),
        geometry: BadgeGeometry(
          width: sizeWidth,
          height: sizeHeight,
          alignment: alignment,
        ),
      ),
    );
  }
}
