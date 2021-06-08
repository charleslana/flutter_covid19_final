import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/alert_error.dart';
import 'package:flutter_covid19_final/src/components/container_option_card.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/controllers/api_news.dart';
import 'package:flutter_covid19_final/src/models/news.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class NewsGlobal extends StatefulWidget {
  @override
  _NewsGlobalState createState() => _NewsGlobalState();
}

class _NewsGlobalState extends State<NewsGlobal> {
  final height = AppBar().preferredSize.height;
  Map<String, News> _options = {};
  final title = 'Notícias Globais'.toUpperCase();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  _alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertError();
      },
    ).then((value) => Navigator.of(context).pushNamed(AppRoutes.HOME));
  }

  Future<dynamic> _getNews() async {
    final data = await ApiNews().getByType('Global');
    if (data == null) {
      return _alert();
    }
    data.forEach((key, values) {
      _options.putIfAbsent(
        key as String,
        () => News(
          id: key,
          title: values['title'],
          message: values['message'],
          urlImage: values['urlImage'],
          source: values['source'],
          type: values['type'],
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('assets/images/icons/news_global.png'),
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/news-global',
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
