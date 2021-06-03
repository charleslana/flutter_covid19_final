import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/container_option_card.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/data/data_news_local.dart';
import 'package:flutter_covid19_final/src/models/container_list.dart';

class NewsLocal extends StatefulWidget {
  const NewsLocal({Key? key}) : super(key: key);

  @override
  _NewsLocalState createState() => _NewsLocalState();
}

class _NewsLocalState extends State<NewsLocal> {
  final height = AppBar().preferredSize.height;
  final Map<String, ContainerList> _options = {...DATA_NEWS_LOCAL};
  final title = 'Notícias Locais'.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/news_local.png'),
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
            option: '/news-local',
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
