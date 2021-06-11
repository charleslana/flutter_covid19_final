import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_covid19_final/src/components/alert_error.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/components/sliver_grid_container.dart';
import 'package:flutter_covid19_final/src/controllers/api_covid.dart';
import 'package:flutter_covid19_final/src/enum/indexes_filter.dart';
import 'package:flutter_covid19_final/src/models/covid_country.dart';
import 'package:flutter_covid19_final/src/models/covid_history.dart';
import 'package:flutter_covid19_final/src/models/covid_vaccine.dart';
import 'package:flutter_covid19_final/src/models/covid_world_wide.dart';
import 'package:flutter_covid19_final/src/models/grid_indexes.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:flutter_covid19_final/src/utils/last_month.dart';

class Indexes extends StatefulWidget {
  const Indexes({Key? key}) : super(key: key);

  @override
  _IndexesState createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> {
  final height = AppBar().preferredSize.height;
  final getYear = DateFormat.y().format(DateTime.now());
  final title = 'Índices '.toUpperCase();

  late Future<CovidHistory> _futureCovidHistory;
  late Future<CovidWorldWide> _futureCovidWorldWide;
  late Future<CovidCountry> _futureCovidByCountry;
  late Future<CovidVaccine> _futureCovidVaccine;

  late List<FlSpot> _casesGlobal = [];
  late List<FlSpot> _deathsGlobal = [];
  late List<FlSpot> _recoveredGlobal = [];

  late String _casesTotal;
  late String _deathsTotal;
  late String _recoveredTotal;

  late String _countryCases;
  late String _countryDeaths;
  late String _countryRecovered;
  late String _todayCountryCases;
  late String _todayCountryDeaths;
  late String _todayCountryRecovered;

  late String _vaccinesBrazil;

  bool _isLoading = true;
  IndexesFilter? _filter = IndexesFilter.globalGraphics;

  @override
  void initState() {
    super.initState();

    _fetchDataCovid();
  }

  _alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertError();
      },
    ).then((value) => Navigator.of(context).pushNamed(AppRoutes.HOME));
  }

  _fetchDataCovid() async {
    _futureCovidHistory = ApiCovid().fetchCovidHistory();
    _futureCovidWorldWide = ApiCovid().fetchCovidWorldWide();
    _futureCovidByCountry = ApiCovid().fetchCovidByCountry('brazil');
    _futureCovidVaccine = ApiCovid().fetchCovidVaccine();

    late double count = 0;
    final formatter = NumberFormat('###,###.###', 'pt_BR');

    await _futureCovidHistory.then((response) {
      response.cases.forEach((key, value) => {
            _casesGlobal.add(FlSpot(count, value.toDouble())),
            count++,
          });

      count = 0;

      response.deaths.forEach((key, value) => {
            _deathsGlobal.add(FlSpot(count, value.toDouble())),
            count++,
          });

      count = 0;

      response.recovered.forEach((key, value) => {
            _recoveredGlobal.add(FlSpot(count, value.toDouble())),
            count++,
          });
    }).catchError((onError) => _alert());

    await _futureCovidWorldWide
        .then((response) => {
              _casesTotal = formatter.format(response.cases),
              _deathsTotal = formatter.format(response.deaths),
              _recoveredTotal = formatter.format(response.recovered),
            })
        .catchError((onError) => _alert());

    await _futureCovidByCountry
        .then((response) => {
              _countryCases = formatter.format(response.cases),
              _countryDeaths = formatter.format(response.deaths),
              _countryRecovered = formatter.format(response.recovered),
              _todayCountryCases = formatter.format(response.todayCases),
              _todayCountryDeaths = formatter.format(response.todayDeaths),
              _todayCountryRecovered =
                  formatter.format(response.todayRecovered),
            })
        .catchError((onError) => _alert());

    await _futureCovidVaccine.then((response) {
      response.list[27]['timeline'].forEach((key, value) => {
            _vaccinesBrazil = formatter.format(value),
          });
      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) => _alert());
  }

  _changeFilter(IndexesFilter? value) {
    setState(() {
      _filter = value;
    });
  }

  LineChartData dataGlobal() {
    final lastMonth = new LastMonth();
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return lastMonth.get(60);
              case 50:
                return lastMonth.get(30);
              case 90:
                return lastMonth.get(0);
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 50000000:
                return '50M';
              case 100000000:
                return '100M';
              case 150000000:
                return '150M';
              case 200000000:
                return '200M';
            }
            return '';
          },
          margin: 8,
          reservedSize: 35,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 100,
      maxY: 200000000,
      minY: 0,
      lineBarsData: linesBarDataGlobal(),
    );
  }

  List<LineChartBarData> linesBarDataGlobal() {
    final lineChartBarDataCases = LineChartBarData(
      spots: _casesGlobal,
      isCurved: true,
      colors: [
        Color(0xff4af699),
      ],
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final lineChartBarDataDeaths = LineChartBarData(
      spots: _deathsGlobal,
      isCurved: true,
      colors: [
        Color(0xffdb4437),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        Color(0x00aa4cfc),
      ]),
    );

    final lineChartBarDataRecovered = LineChartBarData(
      spots: _recoveredGlobal,
      isCurved: true,
      colors: [
        Color(0xfff4b400),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarDataCases,
      lineChartBarDataDeaths,
      lineChartBarDataRecovered,
    ];
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title + getYear),
          leading: IconButton(
            icon: Image.asset('assets/images/icons/indexes.png'),
            onPressed: () => {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              tooltip: 'Opções',
              onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/indexes',
          ),
        ),
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 80,
                child: DrawerHeader(
                  child: Text(
                    'Escolha um tipo de índice da covid-19',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff65c1bd),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text(
                  'Gráfico global',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                  _changeFilter(IndexesFilter.globalGraphics);
                },
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text(
                  'Números globais',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                  _changeFilter(IndexesFilter.globalNumbers);
                },
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text(
                  'Números no Brasil',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                  _changeFilter(IndexesFilter.brazilData);
                },
              ),
              ListTile(
                leading: Icon(Icons.navigate_next),
                title: Text(
                  'Vacinas no Brasil',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                  _changeFilter(IndexesFilter.brazilVaccine);
                },
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _filter == IndexesFilter.globalGraphics
                ? SingleChildScrollView(
                    child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 0.99,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff0c5299),
                              Color(0xff0c5299),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 37,
                                ),
                                Text(
                                  'Dados da Covid 19',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Global',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Color(0xff4af699),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Causas',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Color(0xffdb4437),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Mortes',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              border: Border.all(
                                                  color: Colors.transparent),
                                              color: Color(0xfff4b400),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Recuperados',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 37,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 16.0,
                                      left: 16.0,
                                    ),
                                    child: LineChart(
                                      dataGlobal(),
                                      swapAnimationDuration:
                                          Duration(milliseconds: 250),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                : _filter == IndexesFilter.globalNumbers
                    ? SliverGridContainer(
                        count: 2,
                        slivers: [
                          GridIndexes(
                            title: 'Casos totais global',
                            text: _casesTotal,
                            color: Colors.green[100],
                          ),
                          GridIndexes(
                            title: 'Mortes totais global',
                            text: _deathsTotal,
                            color: Colors.red[200],
                          ),
                          GridIndexes(
                            title: 'Recuperados totais global',
                            text: _recoveredTotal,
                            color: Colors.yellow[300],
                          ),
                        ],
                      )
                    : _filter == IndexesFilter.brazilData
                        ? SliverGridContainer(
                            count: 2,
                            slivers: [
                              GridIndexes(
                                title: 'Casos totais no Brasil',
                                text: _countryCases,
                                color: Colors.green[100],
                              ),
                              GridIndexes(
                                title: 'Mortes totais no Brasil',
                                text: _countryDeaths,
                                color: Colors.red[200],
                              ),
                              GridIndexes(
                                title: 'Recuperados totais no Brasil',
                                text: _countryRecovered,
                                color: Colors.yellow[300],
                              ),
                              GridIndexes(
                                title: 'Casos por dia no Brasil',
                                text: _todayCountryCases,
                                color: Colors.green[100],
                              ),
                              GridIndexes(
                                title: 'Mortes por dia no Brasil.',
                                text: _todayCountryDeaths,
                                color: Colors.red[200],
                              ),
                              GridIndexes(
                                title: 'Recuperados por dia no Brasil.',
                                text: _todayCountryRecovered,
                                color: Colors.yellow[300],
                              ),
                            ],
                          )
                        : SliverGridContainer(
                            count: 1,
                            slivers: [
                              GridIndexes(
                                title: 'Vacinas efetivadas no Brasil',
                                text: _vaccinesBrazil,
                                color: Colors.green[100],
                              ),
                            ],
                          ),
      ),
    );
  }
}
