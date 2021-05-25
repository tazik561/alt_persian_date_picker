import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:flutter/material.dart';

import '../src/date_model.dart';

// ignore: must_be_immutable
class MixedHeaderWidget extends AnimatedWidget {
  final AnimationController controller;
  final DatePickerModel pickerModel;
  final DatePickerTheme theme;
  final VoidCallback changeMonthPrev;
  final VoidCallback changeMonthNext;
  bool isSlideForward = false;

  MixedHeaderWidget({
    Key key,
    @required this.pickerModel,
    @required this.theme,
    @required this.controller,
    @required this.changeMonthPrev,
    @required this.changeMonthNext,
    this.isSlideForward,
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        if (pickerModel.arrowType == "next")
          isSlideForward = true;
        else
          isSlideForward = false;
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              width: 90,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) => Transform(
                  transform: Matrix4.translationValues(
                      controller.value * (isSlideForward ? 100 : -100), 0, 0),
                  child: Opacity(
                    opacity: 1 - controller.value,
                    child: Center(
                      child: Text(
                        "${pickerModel.getMonthName()} ${pickerModel.getYear()}",
                        style: theme.headerStyle,
                      ),
                    ),
                  ),
                ),
              ),
            )),
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
      ],
    );
  }
}
