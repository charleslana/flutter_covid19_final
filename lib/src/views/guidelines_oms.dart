import 'package:flutter/material.dart';
import 'package:flutter_covid19_final/src/components/bubble.dart';
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
            icon: Image.asset('assets/images/icons/guidelines_oms.png'),
            onPressed: () => {},
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: height,
          child: Menu(
            option: '/guidelines-oms',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Bubble(
                              message:
                                  'O que posso fazer para me proteger e evitar transmitir para outras pessoas?',
                              isMe: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        right: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/others/people_right.png',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/others/people_left.png',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Bubble(
                                  message:
                                      'Lave as mãos com água e sabão ou higienizador à base de álcool para matar vírus que podem estar nas suas mãos.',
                                  isMe: true,
                                ),
                                Bubble(
                                  message:
                                      'Mantenha pelo menos 1 metro de distância.',
                                  isMe: true,
                                ),
                                Bubble(
                                  message:
                                      'Pessoas doentes devem adiar ou evitar viajar para as áreas afetadas por coronavírus.',
                                  isMe: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
