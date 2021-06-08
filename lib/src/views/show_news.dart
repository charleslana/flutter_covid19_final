import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';
import 'package:flutter_covid19_final/src/models/news.dart';

class ShowNews extends StatefulWidget {
  const ShowNews({Key? key}) : super(key: key);

  @override
  _ShowNewsState createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  final height = AppBar().preferredSize.height;
  final Map<String, String> _showData = {};

  void _loadShowData(News option) {
    _showData['title'] = option.title.toUpperCase();
    _showData['subTitle'] = option.message;
    _showData['urlImage'] = option.urlImage;
    _showData['source'] = option.source;
    _showData['type'] = option.type == 'Global'
        ? '/news-global'
        : option.type == 'Local'
            ? '/news-local'
            : '/vaccination';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final _option = ModalRoute.of(context)!.settings.arguments;

    if (_option != null) {
      _loadShowData(_option as News);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff37b8ae),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            tooltip: 'Voltar',
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            _showData['title']!,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: false,
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: _showData['type']!,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: _showData['urlImage'] != ''
                    ? Image.network(
                        _showData['urlImage']!,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      )
                    : Image.asset(
                        'assets/images/others/news_blank.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Fonte: ${_showData['source']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _showData['subTitle']!,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
