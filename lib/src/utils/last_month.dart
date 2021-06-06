import 'package:intl/intl.dart';

class LastMonth {
  String get(int value) {
    final String daysAgo =
        DateFormat.M().format(DateTime.now().subtract(Duration(days: value)));

    switch (daysAgo) {
      case '1':
        return 'Janeiro';
      case '2':
        return 'Fevereiro';
      case '3':
        return 'Março';
      case '4':
        return 'Abril';
      case '5':
        return 'Maio';
      case '6':
        return 'Junho';
      case '7':
        return 'Julho';
      case '8':
        return 'Agosto';
      case '9':
        return 'Setemebro';
      case '10':
        return 'Outubro';
      case '11':
        return 'Novembro';
      case '12':
        return 'Dezembro';
    }

    return '';
  }
}
