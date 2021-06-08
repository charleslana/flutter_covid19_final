import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class Menu extends StatelessWidget {
  final String option;
  const Menu({Key? key, required this.option}) : super(key: key);

  _navigateToPage(BuildContext context, String route) {
    final String? currentRoute = ModalRoute.of(context)!.settings.name;
    if (currentRoute != route) {
      Navigator.of(context).pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xff37b8ae),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.NEWS_GLOBAL),
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
                      'assets/images/menu/news_global.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/news_global.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.NEWS_LOCAL),
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
                      'assets/images/menu/news_local.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/news_local.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.INDEXES),
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
                      'assets/images/menu/indexes.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/indexes.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.GUIDELINES_OMS),
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
                      'assets/images/menu/guidelines_oms.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/guidelines_oms.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.CARE_WELL_BEING),
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
                      'assets/images/menu/care_well_being.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/care_well_being.png',
                    width: 40,
                  ),
          ),
          InkWell(
            onTap: () => _navigateToPage(context, AppRoutes.VACCINATION),
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
                      'assets/images/menu/vaccination.png',
                      width: 40,
                    ),
                  )
                : Image.asset(
                    'assets/images/menu/vaccination.png',
                    width: 40,
                  ),
          ),
        ],
      ),
      actions: [
        Container(),
      ],
    );
  }
}
