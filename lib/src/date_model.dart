import 'package:alt_persian_date_picker/src/picker_enum.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:alt_persian_date_picker/src/convert_number.dart';

abstract class BasePickerModel {
  void getJalaliDateSelected();
  String getNow();
  String getMonthNameByIndex(int monthIndex);
  bool isDisable(int item);
  void setArrowType(String type);
}

class MonthPickerModel extends BasePickerModel {
  int startSelectedInitDate;
  Jalali jDate;
  String finalMonth;
  int todayMonthNum;
  List<int> disables = [];
  MonthPickerModel({
    this.startSelectedInitDate,
    this.disables,
  }) {
    getJalaliDateSelected();
    _getTodayMonthNum();
  }

  // int get selectedMonth => int.parse(startSelectedInitDate);
  void setSelectedDay(int monthIndex) {
    startSelectedInitDate = monthIndex;
  }

  @override
  void getJalaliDateSelected() {
    jDate = _getMonth(startSelectedInitDate);
  }

  @override
  String getMonthNameByIndex(int monthIndex) {
    finalMonth = _getMonth(monthIndex).formatter.mN;
    return finalMonth;
  }

  Date _getMonth(int index) {
    return Jalali.now().withDay(1).withMonth(index);
    // return Jalali(1400, 12, 1).formatter.mN;
  }

  @override
  String getNow() {
    return Jalali.now().formatter.mN;
  }

  void _getTodayMonthNum() {
    todayMonthNum = int.parse(Jalali.now().formatter.m);
  }

  bool isSelectedMonth(int monthNum) {
    return startSelectedInitDate == monthNum ? true : false;
  }

  @override
  bool isDisable(int index) {
    bool isDisable = false;
    for (var item in disables) {
      isDisable = item == index ? true : false;
      if (isDisable) break;
    }
    return isDisable;
  }

  @override
  void setArrowType(String type) {}
}

class YearPickerModel extends BasePickerModel {
  int startSelectedInitDate;
  int _firstInitYear;
  Jalali jDate;
  List<int> disables = [];
  List<int> _years = [];
  String _arrowType = 'prev';

  YearPickerModel({
    this.startSelectedInitDate,
    this.disables,
  }) {
    _firstInitYear = this.startSelectedInitDate;
    makeYears();
    jDate = Jalali.now();
  }

  void makeYears() {
    for (var i = this.startSelectedInitDate - 8;
        i < startSelectedInitDate + 8;
        i++) {
      _years.add(i);
    }
  }

  List<int> get years => _years;

  String get arrowType => _arrowType;

  bool isSelectedYear(int year) {
    return year == startSelectedInitDate ? true : false;
  }

  @override
  void getJalaliDateSelected() {}

  @override
  String getMonthNameByIndex(int monthIndex) {
    return "";
  }

  @override
  bool isDisable(int year) {
    bool isDisable = false;
    for (var item in disables) {
      isDisable = item == year ? true : false;
      if (isDisable) break;
    }
    return isDisable;
  }

  void setSelectedYear(int year) {
    startSelectedInitDate = year;
  }

  void changePrevYear() {
    _firstInitYear -= 16;
    startSelectedInitDate = _firstInitYear;
    _years.clear();
    makeYears();
  }

  void changeNextYear() {
    _firstInitYear += 16;
    startSelectedInitDate = _firstInitYear;
    _years.clear();
    makeYears();
  }

  @override
  void setArrowType(String type) {
    _arrowType = type;
  }

  @override
  String getNow() {
    return jDate.formatter.yyyy;
  }
}

class DatePickerModel extends BasePickerModel {
  bool isRangeDate;
  List<String> rangeSelectedDate;
  String startRange;
  String endRange;
  List<String> disables = [];
  Jalali jDate;
  Jalali _orginJDate;
  Jalali _selectedJDate;
  List<dynamic> _allDaysOfTable = [];
  String _arrowType;
  final HeaderType headerType;

  DatePickerModel({
    this.headerType = HeaderType.mix,
    this.rangeSelectedDate,
    this.disables,
    this.isRangeDate = false,
  }) {
    getJalaliDateSelected();
  }

  final weekDaysName = [
    'شنبه',
    'یکشنبه',
    'دوشنبه',
    'سه‌شنبه',
    'چهارشنبه',
    'پنج‌شنبه',
    'جمعه',
  ];

  final seasonName = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];

  List<dynamic> get allDaysOfTable => _allDaysOfTable;

  @override
  void getJalaliDateSelected() {
    rangeSelectedDate = rangeSelectedDate ?? [];
    // if (startSelectedInitDate != null && _isValidDate(startSelectedInitDate)) {
    //   List<String> dates = startSelectedInitDate.split("/");
    //   jDate = Jalali(
    //     int.parse(dates[0]),
    //     int.parse(dates[1]),
    //     int.parse(dates[2]),
    //   );
    // } else {
    jDate = Jalali.now();
    // }
    _orginJDate = jDate;
  }

  String get arrowType => _arrowType;

  @override
  String getMonthNameByIndex(int monthIndex) {
    return "";
  }

  @override
  String getNow() {
    Jalali date = Jalali.now();
    return _getDateString(date);
  }

  @override
  bool isDisable(int day) {
    bool isDisable = false;
    Jalali date = jDate.copy(day: day);
    String dateString = _getDateString(date);
    if (disables != null && disables.length > 0) {
      for (var item in disables) {
        isDisable =
            _isValidDate(dateString) ? _isDisableDate(dateString, item) : false;
        if (isDisable) break;
      }
    }

    return isDisable;
  }

  bool isStartRanged(int day) {
    if (rangeSelectedDate != null && rangeSelectedDate.length == 2) {
      Jalali sj = _stringToJalali(rangeSelectedDate[0]);
      return jDate.copy(day: day) == sj;
    } else if (rangeSelectedDate != null && rangeSelectedDate.length == 1) {
      Jalali sj = _stringToJalali(rangeSelectedDate[0]);
      return jDate.copy(day: day) == sj;
    }
    return false;
  }

  bool isBetweenRanged(int day) {
    if (rangeSelectedDate != null && rangeSelectedDate.length == 2) {
      Jalali sj = _stringToJalali(rangeSelectedDate[0]);
      Jalali ej = _stringToJalali(rangeSelectedDate[1]);
      return jDate.copy(day: day) > sj && jDate.copy(day: day) < ej;
    }
    return false;
  }

  bool isEndRanged(int day) {
    if (rangeSelectedDate != null && rangeSelectedDate.length == 2) {
      Jalali ej = _stringToJalali(rangeSelectedDate[1]);
      return jDate.copy(day: day) == ej;
    }
    return false;
  }

  String getMonthName() {
    return jDate.formatter.mN;
  }

  String getYear() {
    return jDate.formatter.yyyy;
  }

  void makeDays() {
    _allDaysOfTable.clear();
    int monthLenght = jDate.monthLength;
    int numberOfFirstDayOfMonthInWeek = jDate.copy(day: 1).weekDay;
    for (var i = 1; i <= (numberOfFirstDayOfMonthInWeek + 1); i++) {
      if (i < numberOfFirstDayOfMonthInWeek) _allDaysOfTable.add('');
    }
    List.generate(monthLenght, (index) => _allDaysOfTable.add(index + 1));
  }

  dynamic makeJaliliDateFromDays(dynamic day) {
    if (day == '') return '';
    return jDate.copy(day: day);
  }

  void changeMonth(String type) {
    int year = int.parse(jDate.formatter.y);
    int month = int.parse(jDate.formatter.m);
    if (type == 'next') {
      jDate = jDate.copy(
        year: month == 12 ? year + 1 : year,
        month: month < 12 ? month + 1 : 1,
      );
    } else if (type == 'prev') {
      jDate = jDate.copy(
        month: month > 1 ? month - 1 : 12,
        year: month == 1 ? year - 1 : year,
      );
    } else {}
  }

  void changeYear(String type) {
    int year = int.parse(jDate.formatter.y);
    int month = int.parse(jDate.formatter.m);
    if (type == 'next') {
      jDate = jDate.withYear(year + 1).withMonth(month);
    } else {
      jDate = jDate.withYear(year - 1).withMonth(month);
      // jDate = jDate.copy(month: month, year: year - 1);;
    }
  }

  String _getDateString(Date date) {
    final f = date.formatter;
    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  bool _isValidDate(String date) {
    // 1.YYYY/MM/DD
    // 2.YYYY/MM/D
    // 3.YYYY/M/DD
    // 4.YYYY/M/D

    String pattern = r'^(\d{4})\/(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(date)) {
      return true;
    }
    return false;
  }

  bool _isDisableDate(String date, disable) {
    bool isDisable = false;
    if (weekDaysName.indexOf(disable.toLowerCase()) != -1 && !isDisable) {
      isDisable =
          _stringToJalali(date).weekDay == weekDaysName.indexOf(disable) + 1;
    }
    if (_isValidDate(date) && _isValidDate(disable) && !isDisable) {
      isDisable = _stringToJalali(date) == _stringToJalali(disable);
    }
    return isDisable;
  }

  Jalali _stringToJalali(String date) {
    List split = date.split('/');
    return Jalali(
            int.parse(split[0]), int.parse(split[1]), int.parse(split[2])) ??
        Jalali.now();
  }

  String getStringJalaliSelectedUser(int day) {
    Jalali date = jDate.copy(day: day);
    return _getDateString(date);
  }

  String selectDate() {
    if (isRangeDate) {
      return rangeSelectedDate.length > 0 ? rangeSelectedDate.join("#") : "";
    }
    if (_selectedJDate != null) return _getDateString(_selectedJDate);
    return _getDateString(jDate);
  }

  @override
  void setArrowType(String type) {
    _arrowType = type;
  }

  bool decoratedUserSelectedDate(int day) {
    Jalali date = jDate.copy(day: day);
    if (_selectedJDate != null) {
      return date == _selectedJDate;
    }
    return date == _orginJDate;
  }

  void replaceSelectedDayWithOrgin(int day) {
    if (isRangeDate) {
      if (rangeSelectedDate.length == 2) rangeSelectedDate.clear();
      if (rangeSelectedDate.length >= 0)
        rangeSelectedDate.add(getStringJalaliSelectedUser(day));
    } else {
      // for simple date
      _selectedJDate = jDate.copy(day: day);
    }
  }

  bool setEditabelDate(String date) {
    try {
      final intRegex = RegExp(r'[\u06F0-\u06F90-9]');
      List<String> years =
          intRegex.allMatches(date).map((m) => m.group(0)).toList();

      final stringRegex = RegExp(
          r'[\u0622\u0627\u0628\u067E\u062A-\u062C\u0686\u062D-\u0632\u0698\u0633-\u063A\u0641\u0642\u06A9\u06AF\u0644-\u0648\u06CC]');
      List<String> months =
          stringRegex.allMatches(date).map((m) => m.group(0)).toList();
      int seasonNumber = seasonName.indexOf(months.join("")) + 1;
      String year = years.join("").toEnglish;
      jDate = _stringToJalali("$year/$seasonNumber/${jDate.formatter.d}");
      return true;
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }
}
