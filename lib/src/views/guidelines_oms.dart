import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/menu.dart';

class GuidelinesOms extends StatefulWidget {
  const GuidelinesOms({Key? key}) : super(key: key);

  @override
  _GuidelinesOmsState createState() => _GuidelinesOmsState();
}

class _GuidelinesOmsState extends State<GuidelinesOms> {
  final height = AppBar().preferredSize.height;
  final title = 'Orientações OMS'.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff37b8ae),
          title: Text(title),
          leading: IconButton(
            icon: Image.asset('images/icons/guidelines_oms.png'),
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/guidelines-oms',
          ),
        ),
        body: Center(
          child: Text('Orientações OMS'),
        ),
      ),
    );
  }
}
