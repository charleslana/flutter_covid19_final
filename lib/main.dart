import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:flutter_covid19_final/src/views/home.dart';
import 'package:flutter_covid19_final/src/views/logo.dart';
import 'package:flutter_covid19_final/src/views/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterBirds - Notícias e Informações Covid19',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.LOGO: (_) => Logo(),
          AppRoutes.SPLASHSCREEN: (_) => Splashscreen(),
          AppRoutes.HOME: (_) => Home(),
        },
      ),
    );
  }
}
