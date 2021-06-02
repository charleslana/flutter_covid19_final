import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:flutter_covid19_final/src/views/care_well_being.dart';
import 'package:flutter_covid19_final/src/views/guidelines_oms.dart';
import 'package:flutter_covid19_final/src/views/home.dart';
import 'package:flutter_covid19_final/src/views/indexes.dart';
import 'package:flutter_covid19_final/src/views/logo.dart';
import 'package:flutter_covid19_final/src/views/news_global.dart';
import 'package:flutter_covid19_final/src/views/news_local.dart';
import 'package:flutter_covid19_final/src/views/splashscreen.dart';
import 'package:flutter_covid19_final/src/views/vaccination.dart';

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
          AppRoutes.NEWS_GLOBAL: (_) => NewsGlobal(),
          AppRoutes.NEWS_LOCAL: (_) => NewsLocal(),
          AppRoutes.INDEXES: (_) => Indexes(),
          AppRoutes.GUIDELINES_OMS: (_) => GuidelinesOms(),
          AppRoutes.CARE_WELL_BEING: (_) => CareWellBeing(),
          AppRoutes.VACCINATION: (_) => Vaccination(),
        },
      ),
    );
  }
}
