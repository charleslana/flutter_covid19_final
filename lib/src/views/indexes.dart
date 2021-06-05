import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/alert.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/controllers/api_covid.dart';
import 'package:flutter_covid19_final/src/enum/indexes_filter.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:flutter_covid19_final/src/utils/last_month.dart';

class Indexes extends StatefulWidget {
  const Indexes({Key? key}) : super(key: key);

  @override
  _IndexesState createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> {
  final height = AppBar().preferredSize.height;
  final title = 'Índices'.toUpperCase();

  late String casesAll;
  late String deathsAll;
  late String recoveredAll;

  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];
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
        return Alert();
      },
    ).then((value) => Navigator.of(context).pushNamed(AppRoutes.HOME));
  }

  _fetchDataCovid() async {
    final dataWorldWide = await ApiCovid().getDataWorldWide();
    if (dataWorldWide == null) {
      return _alert();
    }

    casesAll = dataWorldWide[0];
    deathsAll = dataWorldWide[1];
    recoveredAll = dataWorldWide[2];

    final dataHistory = await ApiCovid().getDataHistory();
    if (dataHistory == null) {
      return _alert();
    }

    casesGlobal = dataHistory[0];
    deathsGlobal = dataHistory[1];
    recoveredGlobal = dataHistory[2];
    setState(() {
      _isLoading = false;
    });
  }

  _changeFilter(IndexesFilter? value) {
    setState(() {
      _filter = value;
    });
    Navigator.of(context).pop();
  }

  _options() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha um tipo de índice da covid-19.'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                RadioListTile<IndexesFilter>(
                  title: const Text('Gráfico global'),
                  value: IndexesFilter.globalGraphics,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
                RadioListTile<IndexesFilter>(
                  title: const Text('Números globais'),
                  value: IndexesFilter.globalNumbers,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
                RadioListTile<IndexesFilter>(
                  title: const Text('Números em Brasil'),
                  value: IndexesFilter.brazilData,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  LineChartData dataGlobal() {
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
                return LastMonth().get(60);
              case 50:
                return LastMonth().get(30);
              case 90:
                return LastMonth().get(0);
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
      spots: casesGlobal,
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
      spots: deathsGlobal,
      isCurved: true,
      colors: [
        const Color(0xffdb4437),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    final lineChartBarDataRecovered = LineChartBarData(
      spots: recoveredGlobal,
      isCurved: true,
      colors: [
        const Color(0xfff4b400),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );

    return [
      lineChartBarDataCases,
      lineChartBarDataDeaths,
      lineChartBarDataRecovered,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/indexes.png'),
            onPressed: () => {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.white),
              tooltip: 'Opções',
              onPressed: () => _options(),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/indexes',
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
                                            margin: EdgeInsets.all(10),
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
                                            margin: EdgeInsets.all(10),
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
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            margin: EdgeInsets.all(10),
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
                    ? CustomScrollView(
                        primary: false,
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.all(20),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Casos totais global'),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          casesAll,
                                          style: TextStyle(
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.green[100],
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Mortes totais global'),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          deathsAll,
                                          style: TextStyle(
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.red[200],
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Recuperados totais global'),
                                      FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          recoveredAll,
                                          style: TextStyle(
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Colors.yellow[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Text('Números no Brasil'),
      ),
    );
  }
}
