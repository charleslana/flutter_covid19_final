import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/models/news.dart';
import 'package:flutter_covid19_final/src/routes/app_routes.dart';

class ContainerOptionCard extends StatelessWidget {
  final News option;
  const ContainerOptionCard({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            AppRoutes.SHOW_NEWS,
            arguments: option,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: option.urlImage != ''
                    ? Image.network(
                        option.urlImage,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/others/news_blank.png',
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
              ListTile(
                title: Text(
                  option.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
                subtitle: Text(
                  option.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
