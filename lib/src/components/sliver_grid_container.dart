import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/models/grid_indexes.dart';

class SliverGridContainer extends StatelessWidget {
  final List<GridIndexes> slivers;
  final int count;

  const SliverGridContainer(
      {Key? key, required this.count, required this.slivers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: count,
            children: List.generate(
              slivers.length,
              (index) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(slivers[index].title),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          slivers[index].text,
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: slivers[index].color,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
