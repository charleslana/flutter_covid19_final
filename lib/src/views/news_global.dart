import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/container_option_card.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/data/data_news_global.dart';
import 'package:flutter_covid19_final/src/models/container_list.dart';

class NewsGlobal extends StatefulWidget {
  @override
  _NewsGlobalState createState() => _NewsGlobalState();
}

class _NewsGlobalState extends State<NewsGlobal> {
  final height = AppBar().preferredSize.height;
  final Map<String, ContainerList> _options = {...DATA_NEWS};
  final title = 'Notícias Globais'.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/news_global.png'),
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
            option: '/news-global',
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
