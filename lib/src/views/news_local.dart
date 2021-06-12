import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/alert_error.dart';
import 'package:flutter_covid19_final/src/components/container_option_card.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/controllers/api_news.dart';
import 'package:flutter_covid19_final/src/models/news.dart';
import 'package:flutter_covid19_final/src/models/news_map.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class NewsLocal extends StatefulWidget {
  const NewsLocal({Key? key}) : super(key: key);

  @override
  _NewsLocalState createState() => _NewsLocalState();
}

class _NewsLocalState extends State<NewsLocal> {
  final height = AppBar().preferredSize.height;
  final title = 'Notícias Locais'.toUpperCase();

  late Future<NewsMap> _futureNews;

  late Map<String, News> _news = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  _alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertError();
      },
    ).then((value) => Navigator.of(context).pushNamed(AppRoutes.HOME));
  }

  _fetchNews() async {
    _futureNews = ApiNews().fetchAll();

    await _futureNews.then((response) {
      final Map<String, dynamic> data = new SplayTreeMap<String, dynamic>.from(
          response.map, (a, b) => b.compareTo(a));
      data.forEach(
        (key, value) => {
          if (value['type'] == 'Local')
            {
              _news.putIfAbsent(
                key,
                () => News(
                  id: key,
                  title: value['title'],
                  message: value['message'],
                  urlImage: value['urlImage'],
                  source: value['source'],
                  type: value['type'],
                ),
              ),
            }
        },
      );

      setState(() {
        _isLoading = false;
      });
    }).catchError((onError) => _alert());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('assets/images/icons/news_local.png'),
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/news-local',
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  return ContainerOptionCard(
                    option: _news.values.elementAt(index),
                  );
                },
              ),
      ),
    );
  }
}
