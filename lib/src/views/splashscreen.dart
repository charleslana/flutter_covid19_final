import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/rotated_corner.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushNamed(AppRoutes.HOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RotatedCorner(
            alignment: BadgeAlignment.topLeft,
            sizeWidth: 200,
            sizeHeight: 200,
            color: 0xff65c1bd,
          ),
          RotatedCorner(
            alignment: BadgeAlignment.bottomRight,
            sizeWidth: 100,
            sizeHeight: 100,
            color: 0xff65c1bd,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset('assets/images/logo/covid19.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        'Notícias e Informações Covid 19'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
