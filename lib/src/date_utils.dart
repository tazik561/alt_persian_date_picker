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

Jalali getLastDayOfNextMonth(Jalali date) {
  Jalali lastDayOfMonthDate = date.withDay(date.monthLength);
  DateTime oldDateTime = lastDayOfMonthDate.toDateTime();
  DateTime newDateTime =
      DateTime(oldDateTime.year, oldDateTime.month + 1, oldDateTime.day);
  Jalali nextJdate = Jalali.fromDateTime(newDateTime);
  return nextJdate;
}

Jalali getLastDayOfPrevMonth(Jalali date) {
  Jalali lastDayOfMonthDate = date.withDay(date.monthLength);
  DateTime oldDateTime = lastDayOfMonthDate.toDateTime();
  DateTime newDateTime =
      DateTime(oldDateTime.year, oldDateTime.month - 1, oldDateTime.day);
  Jalali prevJdate = Jalali.fromDateTime(newDateTime);
  return prevJdate;
}

extension JalaliExt on Jalali {
  bool isBefore(Jalali date) {
    return date.compareTo(this) > 0;
  }

  bool isAfter(Jalali date) {
    return date.compareTo(this) < 0;
  }

  bool isAtSameOrBeforAs(Jalali date) {
    return (date.compareTo(this) >= 0);
  }

  bool isAtSameOrAfterAs(Jalali date) {
    return (date.compareTo(this) <= 0);
  }

  bool isAtSameMomentAs(Jalali date) {
    return date.compareTo(this) == 0;
  }

  /// Returns a [Jalali] with just the date of the original.
  Jalali dateOnly() {
    return Jalali(this.year, this.month, this.day);
  }
}
