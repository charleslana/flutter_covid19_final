import 'package:flutter/material.dart';

class AlertError extends StatelessWidget {
  const AlertError({Key? key}) : super(key: key);

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
            'Olá, estamos com alguns problemas técnicos, mas fique tranquilo em breve você poderá acessar novamente, caso o sistema não retorne verifique se sua aplicação está atualizada ;)'),
      ),
      actions: [
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
