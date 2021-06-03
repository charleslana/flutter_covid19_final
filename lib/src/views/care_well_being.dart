import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';

class CareWellBeing extends StatefulWidget {
  const CareWellBeing({Key? key}) : super(key: key);

  @override
  _CareWellBeingState createState() => _CareWellBeingState();
}

class _CareWellBeingState extends State<CareWellBeing> {
  final height = AppBar().preferredSize.height;
  final title = 'Cuidado e Bem-Estar'.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/care_well_being.png'),
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/care-well-being',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(
                    'images/others/care_well_being.png',
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Saúde mental na pandemia do coronavírus: Como manter o bem-estar em tempos de distanciamento social.'
                            .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'A pandemia do coronavírus já dura vários meses e, durante esse período, a liberdade de ir e vir e o convívio social foram limitados. Para cumprir a quarentena de maneira correta, o distanciamento social foi indicado por governos e instituições de saúde no mundo todo. No entanto, a solidão causada por essas restrições levantou outra preocupação: a saúde mental na pandemia. Com uma nova onda de casos crescendo, as medidas de prevenção para COVID-19 ainda devem ser seguidas, mas o cuidado com o bem-estar psíquico deve ser levado a sério.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
