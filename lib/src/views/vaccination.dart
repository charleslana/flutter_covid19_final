import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/container_option_card.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/data/data_vaccination.dart';
import 'package:flutter_covid19_final/src/models/container_list.dart';

class Vaccination extends StatefulWidget {
  const Vaccination({Key? key}) : super(key: key);

  @override
  _VaccinationState createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  final height = AppBar().preferredSize.height;
  final Map<String, ContainerList> _options = {...DATA_VACCINATION};
  final title = 'Vacinação'.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/vaccination.png'),
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
            option: '/vaccination',
          ),
        ),
        body: ListView.builder(
          itemCount: _options.length,
          itemBuilder: (context, index) {
            return ContainerOptionCard(
              option: _options.values.elementAt(index),
            );
          },
        ),
      ),
    );
  }
}
