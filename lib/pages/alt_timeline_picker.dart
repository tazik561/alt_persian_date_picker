import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:alt_persian_date_picker/widget/timeline_date_widget.dart';
import 'package:alt_persian_date_picker/widget/timeline_mix_header_widget.dart';
import 'package:alt_persian_date_picker/widget/today_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class _AltTimeLinePickerState extends State<AltTimeLinePicker> {
  TimelineDatePickerController controller;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    controller = TimelineDatePickerController(widget.pickerModel);
    _init();
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.scrollToSelectedItem();
    });
  }

  void _init() {
    controller.scrollController = _scrollController;

    _scrollController.addListener(() {
      final int scrollDirection =
          _scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse
              ? 1
              : 2;

      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double offset = _scrollController.offset;
      widget.pickerModel.calculateScrollingDateOffset(
          offset, maxScrollExtent, scrollDirection);

      // print("---> scrollDirection $scrollDirection");
      // print("---> maxScrollExtent $maxScrollExtent");

      // print("---> extentAfter $extentAfter");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ValueListenableBuilder(
        valueListenable: widget.pickerModel.jCurrentDate,
        builder: (context, value, child) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.pickerModel.headerType == HeaderType.mix)
              TimelineMixHeaderWidget(
                theme: widget.theme,
                pickerModel: widget.pickerModel,
              ),
            SizedBox(
              height: widget.pickerModel.height,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: widget.pickerModel.daysCount,
                itemBuilder: (context, index) {
                  // print(index);
                  return TimeLineDateWidget(
                    index: index,
                    pickerModel: widget.pickerModel,
                    theme: widget.theme,
                    onConfirm: widget.onConfirm,
                  );
                },
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}

///controller for scrolling the [HorizontalDatePickerWidget]
class TimelineDatePickerController {
  ScrollController scrollController;
  final TimeLinePickerModel pickerModel;

  TimelineDatePickerController(this.pickerModel);

  void scrollToSelectedItem([bool isEnableAnimation = true]) {
    _jumpToSelection();
  }

  ///[index]  listview index
  ///[isEnableAnimation] default set as true, jump with animation
  void _jumpToSelection([bool isEnableAnimation = true]) {
    double maxScrollExtent = scrollController.position.maxScrollExtent;
double offset = scrollController.offset;
    if (isEnableAnimation) {
      scrollController.animateTo(
          pickerModel.calculateDateOffset(maxScrollExtent,offset),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear);
    } else {
      scrollController
          ?.jumpTo(pickerModel.calculateDateOffset(maxScrollExtent,offset));
    }
  }
}
