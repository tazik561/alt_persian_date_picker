import 'dart:math';

import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:alt_persian_date_picker/widget/writable_date_form_widget.dart';
import 'package:flutter/material.dart';

import '../src/date_model.dart';

// ignore: must_be_immutable
class CustomDateHeaderWidget extends AnimatedWidget {
  final AnimationController controller;
  final TextEditingController dateCtl;
  final DatePickerModel pickerModel;
  final DatePickerTheme theme;
  final VoidCallback changeMonthPrev;
  final VoidCallback changeYearPrev;
  final VoidCallback changeMonthNext;
  final VoidCallback changeYearNext;
  final VoidCallback onSubmitted;
  bool isSlideForward = false;

  CustomDateHeaderWidget({
    Key key,
    @required this.pickerModel,
    @required this.theme,
    @required this.controller,
    @required this.changeMonthPrev,
    @required this.changeYearPrev,
    @required this.changeMonthNext,
    @required this.changeYearNext,
    @required this.dateCtl,
    this.onSubmitted,
    this.isSlideForward,
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    // dateCtl.text = "${pickerModel.getMonthName()} ${pickerModel.getYear()}";
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        if (pickerModel.arrowType == "next")
          isSlideForward = true;
        else
          isSlideForward = false;
      }
    });
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: changeYearPrev,
              icon: Card(
                color: Colors.grey[200],
                child: RotatedBox(
                  quarterTurns: 0,
                  child: Icon(
                    Icons.double_arrow,
                    size: 20,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: changeMonthPrev,
              icon: Card(
                color: Colors.grey[200],
                child: Icon(
                  Icons.chevron_left,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: 120,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Transform(
                    transform: Matrix4.translationValues(
                        controller.value * (isSlideForward ? 100 : -100), 0, 0),
                    child: Opacity(
                      opacity: 1 - controller.value,
                      child: WritableDateFormWidget(
                          theme: theme,
                          dateCtl: dateCtl,
                          onSubmitted: (value) {
                            bool result = pickerModel.setEditabelDate(value);
                            if (result) onSubmitted();
                          }),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: changeMonthNext,
              icon: Card(
                color: Colors.grey[200],
                child: Icon(
                  Icons.chevron_right,
                  size: 20,
                ),
              ),
            ),
            IconButton(
              onPressed: changeYearNext,
              icon: Card(
                color: Colors.grey[200],
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.double_arrow,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
