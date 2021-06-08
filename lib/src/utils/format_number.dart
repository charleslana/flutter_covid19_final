import 'package:intl/intl.dart';

class FormatNumber {
  String get(dynamic value) {
    NumberFormat formatter = NumberFormat('###,000');
    return formatter.format(value).replaceAll(',', '.');
  }
}
