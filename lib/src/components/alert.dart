import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.close,
            color: Colors.red,
            size: 30.0,
          ),
          Text('Atenção!'),
        ],
      ),
      content: SingleChildScrollView(
        child: Text(
            'Olá, estamos com alguns problemas técnicos em nosso servidor, mas fique tranquilo em breve você poderá acessar novamente ;)'),
      ),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
