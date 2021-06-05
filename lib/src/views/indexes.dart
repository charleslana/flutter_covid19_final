import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/alert.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/controllers/api_covid.dart';
import 'package:flutter_covid19_final/src/utils/last_month.dart';

class Indexes extends StatefulWidget {
  const Indexes({Key? key}) : super(key: key);

  @override
  _IndexesState createState() => _IndexesState();
}

class _IndexesState extends State<Indexes> {
  final height = AppBar().preferredSize.height;
  final title = 'Índices'.toUpperCase();

  late String? cases;
  late List<FlSpot> casesGlobal = [];
  late List<FlSpot> deathsGlobal = [];
  late List<FlSpot> recoveredGlobal = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataCovid();
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Alert();
      },
    );
  }

  _fetchDataCovid() async {
    cases = await ApiCovid().getDataWorldWide();
    if (cases == null) {
      return _showDialog();
    }

    final dataHistory = await ApiCovid().getDataHistory();
    if (dataHistory == null) {
      return _showDialog();
    }

    casesGlobal = dataHistory[0];
    deathsGlobal = dataHistory[1];
    recoveredGlobal = dataHistory[2];
    setState(() {
      _isLoading = false;
    });
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
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTextStyles: (value) => TextStyle(
            color: Color(0xff72719b),
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
            color: Color(0xff75729e),
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
            color: Color(0xff4e4965),
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
              icon: Image.asset('images/menu/search.png'),
              tooltip: 'Pesquisar',
              onPressed: () => {
                print('appbar clicked'),
              },
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
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: 0.99,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2c274c),
                            Color(0xff46426c),
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
                                  color: Color(0xff827daa),
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
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        color: Color(0xff4af699),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            'Causas',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        color: Color(0xffdb4437),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            'Mortes',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        color: Color(0xfff4b400),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            'Recuperados',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
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
                ),
              ),
      ),
    );
  }
}
