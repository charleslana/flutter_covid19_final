import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff37b8ae),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.NEWS_GLOBAL),
            child: Image.asset(
              'images/menu/news_global.png',
              width: 40,
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.NEWS_LOCAL),
            child: Image.asset(
              'images/menu/news_local.png',
              width: 40,
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.INDEXES),
            child: Image.asset(
              'images/menu/indexes.png',
              width: 40,
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.GUIDELINES_OMS),
            child: Image.asset(
              'images/menu/guidlines_oms.png',
              width: 40,
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.CARE_WELL_BEING),
            child: Image.asset(
              'images/menu/care_well_being.png',
              width: 40,
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.VACCINATION),
            child: Image.asset(
              'images/menu/vaccination.png',
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}
