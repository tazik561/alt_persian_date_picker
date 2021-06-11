import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:flutter/material.dart';

class TimeLineDateWidget extends StatelessWidget {
  final TimeLinePickerModel pickerModel;
  final DatePickerTheme theme;
  final DateChangedCallback onConfirm;
  final int index;

  TimeLineDateWidget({
    this.pickerModel,
    this.theme,
    this.onConfirm,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: pickerModel.width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: pickerModel.selectedDate(index)
              ? theme.selectedItemColor
              : theme.noneSelectedItemColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Text(pickerModel.getDate(index).split(" ")[0]),
              Text(
                pickerModel.getDate(index).split(" ")[1],
                style: theme.daysNumberTextStyle,
              ),
              Text(pickerModel.getDate(index).split(" ")[2]),
              // Text(
              //     new DateFormat("MMM", locale)
              //         .format(date)
              //         .toUpperCase(), // Month
              //     style: monthTextStyle),
              // Text(date.day.toString(), // Date
              //     style: dateTextStyle),
              // Text(
              //     new DateFormat("E", locale)
              //         .format(date)
              //         .toUpperCase(), // WeekDay
              //     style: dayTextStyle)
            ],
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onConfirm != null) {
          // Call the onDateSelected Function
          onConfirm("this.date");
        }
      },
    );
  }
}
