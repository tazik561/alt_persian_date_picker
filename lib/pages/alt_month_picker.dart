import 'package:alt_persian_date_picker/src/date_model.dart';
import 'package:alt_persian_date_picker/src/partition.dart';
import 'package:alt_persian_date_picker/widget/main_button_widget.dart';
import 'package:flutter/material.dart';

import '../alt_persian_date_picker.dart';

class AltMonthPicker extends StatefulWidget {
  final MonthPickerModel pickerModel;
  final DatePickerTheme theme;
  final DateChangedCallback onConfirm;
  const AltMonthPicker({Key key, this.pickerModel, this.theme, this.onConfirm})
      : super(key: key);

  @override
  _AltMonthPickerState createState() => _AltMonthPickerState();
}

class _AltMonthPickerState extends State<AltMonthPicker>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  List<Widget> months = [];

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animController.forward();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  void makeDateNameWidgetList() {
    months = List.generate(12, (index) {
      return GestureDetector(
        onTap: () {
          if (!widget.pickerModel.isDisable(index + 1))
            widget.pickerModel.setSelectedDay(index + 1);
          setState(() {});
        },
        child: Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            color: widget.pickerModel.isDisable(index + 1)
                ? widget.theme.disableItemColor
                : widget.pickerModel.isSelectedMonth(index + 1)
                    ? widget.theme.selectedItemColor
                    : widget.pickerModel.todayMonthNum == index + 1
                        ? Colors.grey[300]
                        : widget.theme.noneSelectedItemColor,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            boxShadow: widget.pickerModel.startSelectedInitDate == index + 1
                ? []
                : [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0.0, 0.0),
                        spreadRadius: .1,
                        blurRadius: .5)
                  ],
          ),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(3),
          child: Container(
            padding: EdgeInsets.all(2),
            child: Center(
              child: Text(
                '${widget.pickerModel.getMonthNameByIndex(index + 1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: widget.pickerModel.startSelectedInitDate == index + 1
                        ? widget.theme.selectedText
                        : widget.theme.noneSelectedText,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    makeDateNameWidgetList();

    List chunks = partition(months, 3).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${widget.pickerModel.getMonthNameByIndex(widget.pickerModel.startSelectedInitDate)}',
                  textAlign: TextAlign.right,
                  style: widget.theme.headerStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 2,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey[300].withOpacity(.7),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: chunks.map((row) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) => Opacity(
                          opacity: animController.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: row,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: MainButtonWidget(
                    theme: widget.theme,
                    onConfirm: () {
                      widget.onConfirm(widget.pickerModel.finalMonth);
                      Navigator.of(context).pop();
                    },
                    onNow: () {
                      widget.onConfirm(widget.pickerModel.getNow());
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
