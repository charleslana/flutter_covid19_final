import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class Menu extends StatelessWidget {
  final String option;
  const Menu({Key? key, required this.option}) : super(key: key);

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
            child: option == AppRoutes.NEWS_GLOBAL
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/news_global.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/news_global.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.NEWS_LOCAL),
            child: option == AppRoutes.NEWS_LOCAL
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/news_local.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/news_local.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.INDEXES),
            child: option == AppRoutes.INDEXES
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/indexes.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/indexes.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.GUIDELINES_OMS),
            child: option == AppRoutes.GUIDELINES_OMS
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/guidelines_oms.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/guidelines_oms.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.CARE_WELL_BEING),
            child: option == AppRoutes.CARE_WELL_BEING
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/care_well_being.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/care_well_being.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.VACCINATION),
            child: option == AppRoutes.VACCINATION
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color(0xff0c5299), Color(0xff0c5299)],
                        stops: [
                          0.0,
                          0.5,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.asset(
                      'images/menu/vaccination.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'images/menu/vaccination.png',
                    width: 40,
                  ),
          ),
        ],
      ),
    );
  }
}
