import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/alert_error.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/components/sliver_grid_container.dart';
import 'package:flutter_covid19_final/src/controllers/api_covid.dart';
import 'package:flutter_covid19_final/src/enum/indexes_filter.dart';
import 'package:flutter_covid19_final/src/models/grid_indexes.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';
import 'package:flutter_covid19_final/src/utils/last_month.dart';
import 'package:intl/intl.dart';

class Indexes extends StatefulWidget {
  const Indexes({Key? key}) : super(key: key);

  @override
  _IndexesState createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> {
  final height = AppBar().preferredSize.height;
  final getYear = DateFormat.y().format(DateTime.now());
  final title = 'Índices '.toUpperCase();
  final apiCovid = new ApiCovid();

  late List<String> dataAll = [];
  late List<String> dataBrazil = [];

  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];

  late String vaccinesBrazil;

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
    final dataWorldWide = await apiCovid.getDataWorldWide();
    if (dataWorldWide == null) {
      return _alert();
    }

    dataWorldWide.forEach((value) => dataAll.add(value));

    final dataHistory = await apiCovid.getDataHistory();
    if (dataHistory == null) {
      return _alert();
    }

    casesGlobal = dataHistory[0];
    deathsGlobal = dataHistory[1];
    recoveredGlobal = dataHistory[2];

    final dataByCountry = await apiCovid.getDataByCountry();
    if (dataByCountry == null) {
      return _alert();
    }

    dataByCountry.forEach((value) => dataBrazil.add(value));

    final dataVaccinesBrazil = await apiCovid.getDataVaccine();
    if (dataVaccinesBrazil == null) {
      return _alert();
    }

    vaccinesBrazil = dataVaccinesBrazil;

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
                  title: Text('Gráfico global'),
                  value: IndexesFilter.globalGraphics,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
                RadioListTile<IndexesFilter>(
                  title: Text('Números globais'),
                  value: IndexesFilter.globalNumbers,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
                Divider(),
                RadioListTile<IndexesFilter>(
                  title: Text('Números no Brasil'),
                  value: IndexesFilter.brazilData,
                  groupValue: _filter,
                  onChanged: (IndexesFilter? value) {
                    _changeFilter(value);
                  },
                ),
                RadioListTile<IndexesFilter>(
                  title: Text('Vacinas no Brasil'),
                  value: IndexesFilter.brazilVaccine,
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
      spots: recoveredGlobal,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title + getYear),
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
                    ? SliverGridContainer(
                        count: 2,
                        slivers: [
                          GridIndexes(
                            title: 'Casos totais global',
                            text: dataAll[0],
                            color: Colors.green[100],
                          ),
                          GridIndexes(
                            title: 'Mortes totais global',
                            text: dataAll[1],
                            color: Colors.red[200],
                          ),
                          GridIndexes(
                            title: 'Recuperados totais global',
                            text: dataAll[2],
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
                                text: dataBrazil[0],
                                color: Colors.green[100],
                              ),
                              GridIndexes(
                                title: 'Mortes totais no Brasil',
                                text: dataBrazil[1],
                                color: Colors.red[200],
                              ),
                              GridIndexes(
                                title: 'Recuperados totais no Brasil',
                                text: dataBrazil[2],
                                color: Colors.yellow[300],
                              ),
                              GridIndexes(
                                title: 'Casos totais no Brasil por dia',
                                text: dataBrazil[3],
                                color: Colors.green[100],
                              ),
                              GridIndexes(
                                title: 'Mortes totais no Brasil por dia',
                                text: dataBrazil[4],
                                color: Colors.red[200],
                              ),
                              GridIndexes(
                                title: 'Recuperados totais no Brasil por dia',
                                text: dataBrazil[5],
                                color: Colors.yellow[300],
                              ),
                            ],
                          )
                        : SliverGridContainer(
                            count: 1,
                            slivers: [
                              GridIndexes(
                                title: 'Vacinas efetivadas no Brasil',
                                text: vaccinesBrazil,
                                color: Colors.green[100],
                              ),
                            ],
                          ),
      ),
    );
  }
}
