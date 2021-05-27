import 'package:flutter/material.dart';
import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';

// ignore: must_be_immutable
class DayContainer extends StatelessWidget {
  final DatePickerModel pickerModel;
  final dynamic day;
  final DatePickerTheme theme;
  final ValueChanged<int> onTap;
  bool _isDisable = false;
  bool _isBetweenRange = false;
  bool _isStartRange = false;
  bool _isEndRange = false;

  DayContainer({
    Key key,
    @required this.pickerModel,
    @required this.theme,
    @required this.onTap,
    this.day,
  }) {
    _isBetweenRange = day != '' ? pickerModel.isBetweenRanged(day) : false;
    _isStartRange = day != '' ? pickerModel.isStartRanged(day) : false;
    _isEndRange = day != '' ? pickerModel.isEndRanged(day) : false;
  }

  final cellWidth = 50.0;
  final cellHeight = 35.0;

  Decoration makeDecoration() {
    if (_isStartRange && _isEndRange == null) {
      return BoxDecoration(
          color: theme.selectedItemColor, shape: BoxShape.circle);
    } else if (_isStartRange) {
      return BoxDecoration(
        color: theme.selectedItemColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0.0, 2.0),
              spreadRadius: 1.0,
              blurRadius: 1.0)
        ],
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(50.0),
        ),
      );
    }
    if (_isBetweenRange)
      return BoxDecoration(
        color: theme.selectedItemColor.withOpacity(0.3),
        shape: BoxShape.rectangle,
      );
    if (_isEndRange != null && _isEndRange)
      return BoxDecoration(
        color: theme.selectedItemColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0.0, 4.0),
              spreadRadius: -2.0,
              blurRadius: 1.0)
        ],
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50.0),
        ),
      );
    return BoxDecoration();
  }

  @override
  Widget build(BuildContext context) {
    _isDisable = day != '' ? pickerModel.isDisable(day) : false;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (day != '' && !_isDisable)
          ? () {
              pickerModel.replaceSelectedDayWithOrgin(day);
              onTap(day);
            }
          : null,
      child: day != ''
          ? Container(
              width: cellWidth,
              height: cellHeight,
              decoration: pickerModel.isRangeDate
                  ? makeDecoration()
                  : pickerModel.decoratedUserSelectedDate(day)
                      ? BoxDecoration(
                          color: theme.selectedItemColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0.0, 2.0),
                                spreadRadius: 2.0,
                                blurRadius: 2.0)
                          ],
                          shape: BoxShape.circle)
                      : null,
              child: Center(
                child: Text(
                  day.toString(),
                  textAlign: TextAlign.center,
                  style: _isDisable
                      ? theme.disablesTextStyle
                      : theme.daysNumberTextStyle,
                ),
              ),
            )
          : Container(
              width: cellWidth,
              height: cellHeight,
            ),
    );
  }
}
