import 'package:shamsi_date/shamsi_date.dart';

String getDateString(Date date) {
  final f = date.formatter;
  return '${f.yyyy}/${f.mm}/${f.dd}';
}

Jalali stringToJalali(String date) {
  List split = date.split('/');
  return Jalali(
          int.parse(split[0]), int.parse(split[1]), int.parse(split[2])) ??
      Jalali.now();
}
