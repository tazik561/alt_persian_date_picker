import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  runApp(MyApp());
}

const IRAN_SANS = "IRANSans";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alt persian date picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: IRAN_SANS,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showToast(String date) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(date),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("persian date picker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.month,
                  theme: DatePickerTheme(
                      noneSelectedItemColor: Colors.white,
                      selectedItemColor: Colors.greenAccent,
                      disableItemColor: Colors.redAccent),
                  pickerModel: MonthPickerModel(
                    startSelectedInitDate: 4,
                    disables: [1, 5],
                  ),
                  onConfirm: (time) {
                    print("Selected month is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("ماه"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.year,
                  theme: DatePickerTheme(
                      noneSelectedItemColor: Colors.white,
                      selectedItemColor: Colors.greenAccent,
                      disableItemColor: Colors.redAccent),
                  pickerModel: YearPickerModel(
                    startSelectedInitDate: 1400,
                    disables: [1405, 1395],
                  ),
                  onConfirm: (time) {
                    print("Selected year is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("سال"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.date,
                  theme: DatePickerTheme(
                      selectedItemColor: Colors.purple,
                      backgroundColor: Colors.white,
                      headerStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      daysNameTextStyle: const TextStyle(
                          color: Color(0xFFabb9c4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      disablesTextStyle: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      daysNumberTextStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      buttonColor: Colors.pink),
                  pickerModel: DatePickerModel(
                    headerType: HeaderType.mix,
                    disables: ['جمعه', '1400/03/17', '1400/02/5', '1399/12/21'],
                  ),
                  onConfirm: (time) {
                    print("Selected date is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("تاریخ"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.date,
                  theme: DatePickerTheme(
                      selectedItemColor: Colors.blue,
                      backgroundColor: Colors.deepOrange,
                      headerStyle: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      daysNameTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      disablesTextStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      daysNumberTextStyle: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      buttonColor: Colors.orange),
                  pickerModel: DatePickerModel(
                    headerType: HeaderType.seprated,
                    disables: ['جمعه', '1400/03/17', '1400/02/5', '1399/12/21'],
                  ),
                  onConfirm: (time) {
                    print("Selected date is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text(" تاریخ با هدر جدا"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.date,
                  theme: DatePickerTheme(
                      selectedItemColor: Colors.yellow,
                      backgroundColor: Colors.pink,
                      headerStyle: const TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      daysNameTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      disablesTextStyle: const TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      daysNumberTextStyle: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      buttonColor: Colors.lime,
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "ماه و سال",
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        errorStyle:
                            TextStyle(fontSize: 12.0, color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      )),
                  pickerModel: DatePickerModel(
                    headerType: HeaderType.writable,
                    // startSelectedInitDate: "1400/02/29",
                    disables: ['جمعه', '1400/03/17', '1400/02/5', '1399/12/21'],
                  ),
                  onConfirm: (time) {
                    print("Selected date is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("تاریخ تایپی"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.rangedate,
                  theme: DatePickerTheme(
                    selectedItemColor: Colors.yellow,
                    backgroundColor: Colors.blueGrey,
                    headerStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    daysNameTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    disablesTextStyle: const TextStyle(
                        color: Colors.purple,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    daysNumberTextStyle: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    buttonColor: Colors.lime,
                  ),
                  pickerModel: DatePickerModel(
                    headerType: HeaderType.mix,
                    isRangeDate: true,
                    rangeSelectedDate: ['1400/3/1', '1400/3/7'],
                    disables: [
                      'شنبه',
                      '1400/03/17',
                    ],
                  ),
                  onConfirm: (time) {
                    print("Selected date is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("بازه تاریخی"),
            ),
            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.timeline,
                  theme: DatePickerTheme(
                      noneSelectedItemColor: Colors.grey[200],
                      selectedItemColor: Colors.blueGrey,
                      disableItemColor: Colors.redAccent,
                      daysNumberTextStyle: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                  pickerModel: TimeLinePickerModel(
                      widgetWidth: MediaQuery.of(context).size.width,
                      startDate: Jalali(1400, 1),
                      initialSelectedDate: Jalali(1400, 6, 15),
                      endDate: Jalali(1401, 1),
                      width: 70,
                      height: 80),
                  onConfirm: (time) {
                    print("Selected month is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("دیت افقی"),
            ),
          ],
        ),
      ),
    );
  }
}
