import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

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
    return Container(
      child: Image.asset(
        'images/logo/logo.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.centerRight,
      ),
    );
  }
}
