import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/models/container_list.dart';

class ContainerOptionCard extends StatelessWidget {
  final ContainerList option;
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
          onTap: () => print('clicked'),
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
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'images/others/news_blank.png',
                        height: 150,
                        fit: BoxFit.fill,
                      ),
              ),
              ListTile(
                title: Text(option.title),
                subtitle: Text(option.subTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
