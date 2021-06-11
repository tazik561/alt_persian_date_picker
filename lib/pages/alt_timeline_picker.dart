import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:alt_persian_date_picker/widget/timeline_date_widget.dart';
import 'package:flutter/material.dart';

class AltTimeLinePicker extends StatefulWidget {
  final TimeLinePickerModel pickerModel;
  final DatePickerTheme theme;
  final DateChangedCallback onConfirm;

  const AltTimeLinePicker({
    Key key,
    this.pickerModel,
    this.theme,
    this.onConfirm,
  }) : super(key: key);

  @override
  _AltTimeLinePickerState createState() => _AltTimeLinePickerState();
}

class _AltTimeLinePickerState extends State<AltTimeLinePicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  TextEditingController dateCtl;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.pickerModel.daysCount,
          itemBuilder: (context, index) {
            print(index);
            return TimeLineDateWidget(
              index: index,
              pickerModel: widget.pickerModel,
              theme: widget.theme,
              onConfirm: widget.onConfirm,
            );
          },
        ),
      ),
    );
  }
}
