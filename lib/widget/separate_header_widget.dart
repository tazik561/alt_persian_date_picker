import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:flutter/material.dart';

import '../src/date_model.dart';

// ignore: must_be_immutable
class SeparateHeaderWidget extends AnimatedWidget {
  final bool yearSlide;
  final bool monthSlide;
  final AnimationController controller;
  final DatePickerModel pickerModel;
  final DatePickerTheme theme;
  final VoidCallback changeMonthPrev;
  final VoidCallback changeMonthNext;
  final VoidCallback changeYearPrev;
  final VoidCallback changeYearNext;
  bool isSlideForward = false;

  SeparateHeaderWidget(
      {Key key,
      @required this.pickerModel,
      @required this.theme,
      @required this.controller,
      @required this.changeMonthPrev,
      @required this.changeMonthNext,
      @required this.changeYearPrev,
      @required this.changeYearNext,
      this.isSlideForward,
      this.monthSlide,
      this.yearSlide})
      : super(key: key, listenable: controller);

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
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: changeYearPrev,
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
                      child: yearSlide
                          ? Transform(
                              transform: Matrix4.translationValues(
                                  controller.value *
                                      (isSlideForward ? 100 : -100),
                                  0,
                                  0),
                              child: Opacity(
                                opacity: 1 - controller.value,
                                child: SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      "${pickerModel.getYear()}",
                                      style: theme.headerStyle,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 80,
                              child: Center(
                                child: Text(
                                  "${pickerModel.getYear()}",
                                  style: theme.headerStyle,
                                ),
                              ),
                            ),
                    ),
                    IconButton(
                      onPressed: changeYearNext,
                      icon: Card(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.chevron_right,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                child: GestureDetector(
                  onTap: () {},
                  child: monthSlide
                      ? Transform(
                          transform: Matrix4.translationValues(
                              controller.value * (isSlideForward ? 100 : -100),
                              0,
                              0),
                          child: Opacity(
                            opacity: 1 - controller.value,
                            child: SizedBox(
                                width: 80,
                                child: Center(
                                  child: Text(
                                    "${pickerModel.getMonthName()} ",
                                    style: theme.headerStyle,
                                  ),
                                )),
                          ),
                        )
                      : SizedBox(
                          width: 80,
                          child: Center(
                            child: Text(
                              "${pickerModel.getMonthName()} ",
                              style: theme.headerStyle,
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
            ],
          ),
        ],
      ),
    );
  }
}
