import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/rotated_corner.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'dart:math' as math;

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(AppRoutes.SPLASHSCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RotatedCorner(
            alignment: BadgeAlignment.topLeft,
            sizeWidth: 50,
            sizeHeight: 50,
            color: 0xff0c5299,
          ),
          RotatedCorner(
            alignment: BadgeAlignment.bottomLeft,
            sizeWidth: 150,
            sizeHeight: 150,
            color: 0xff0c5299,
          ),
          Center(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: FixedColumnWidth(200),
              children: [
                TableRow(
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset('assets/images/logo/logo.png'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'Flutter',
                            style: TextStyle(
                              fontFamily: 'Retroyal',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            'Birds',
                            style: TextStyle(
                              fontFamily: 'Skorid',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: SizedBox(
                        height: 150,
                        child: Image.asset('assets/images/logo/logo.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Center(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         width: 200,
          //         child: Image.asset('assets/images/logo/logo.png'),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.all(30),
          //         child: SizedBox(
          //           width: double.infinity,
          //           child: FittedBox(
          //             fit: BoxFit.cover,
          //             child: Text(
          //               'Flutter',
          //               style: TextStyle(
          //                 fontSize: 80,
          //                 fontWeight: FontWeight.bold,
          //                 fontStyle: FontStyle.normal,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.all(30),
          //         child: SizedBox(
          //           width: double.infinity,
          //           child: FittedBox(
          //             fit: BoxFit.cover,
          //             child: Text(
          //               'Birds',
          //               style: TextStyle(
          //                 fontSize: 60,
          //                 fontWeight: FontWeight.bold,
          //                 fontStyle: FontStyle.normal,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 200,
          //         child: Image.asset('assets/images/logo/logo.png'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
