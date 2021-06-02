import 'package:flutter_covid19_final/src/models/grid_home.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

const DATA_HOME = {
  '1': const GridHome(
    title: 'Notícias Globais',
    pathImage: 'images/icons/news_global.png',
    backgroundColor: 0xff78c2e1,
    color: 0xff000000,
    route: AppRoutes.NEWS_GLOBAL,
  ),
  '2': const GridHome(
    title: 'Notícias Locais',
    pathImage: 'images/icons/news_local.png',
    backgroundColor: 0xff0c5299,
    color: 0xffffffff,
    route: AppRoutes.NEWS_LOCAL,
  ),
  '3': const GridHome(
    title: 'Índices',
    pathImage: 'images/icons/indexes.png',
    backgroundColor: 0xff78c2e1,
    color: 0xff000000,
    route: AppRoutes.INDEXES,
  ),
  '4': const GridHome(
    title: 'Orientações OMS',
    pathImage: 'images/icons/guidlines_oms.png',
    backgroundColor: 0xff0c5299,
    color: 0xffffffff,
    route: AppRoutes.GUIDELINES_OMS,
  ),
  '5': const GridHome(
    title: 'Cuidado e Bem Estar',
    pathImage: 'images/icons/care_well_being.png',
    backgroundColor: 0xff78c2e1,
    color: 0xff000000,
    route: AppRoutes.CARE_WELL_BEING,
  ),
  '6': const GridHome(
    title: 'Vacinação',
    pathImage: 'images/icons/vaccination.png',
    backgroundColor: 0xff0c5299,
    color: 0xffffffff,
    route: AppRoutes.VACCINATION,
  ),
};
