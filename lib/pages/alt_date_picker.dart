import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:alt_persian_date_picker/src/partition.dart';
import 'package:alt_persian_date_picker/widget/custom_date_header_widget.dart';
import 'package:alt_persian_date_picker/widget/day_container.dart';
import 'package:alt_persian_date_picker/widget/main_button_widget.dart';
import 'package:alt_persian_date_picker/widget/mixed_header_widget.dart';
import 'package:alt_persian_date_picker/widget/separate_header_widget.dart';
import 'package:alt_persian_date_picker/widget/swap_page_builder.dart';
import 'package:alt_persian_date_picker/widget/today_header_widget.dart';
import 'package:flutter/material.dart';

class AltDatePicker extends StatefulWidget {
  final DatePickerModel pickerModel;
  final DatePickerTheme theme;
  final DateChangedCallback onConfirm;

  const AltDatePicker({
    Key key,
    this.pickerModel,
    this.theme,
    this.onConfirm,
  }) : super(key: key);

  @override
  _AltDatePickerState createState() => _AltDatePickerState();
}

class _AltDatePickerState extends State<AltDatePicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  TextEditingController dateCtl;
  final cellWidth = 50.0;
  final cellHeight = 35.0;
  bool _isSweeped = false;
  bool isSlideAnimated = false;
  bool yearSlide = false;
  bool monthSlide = false;

  @override
  void initState() {
    dateCtl = TextEditingController();
    initTextController();
    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
        if (widget.pickerModel.arrowType == "next")
          isSlideAnimated = true;
        else
          isSlideAnimated = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    dateCtl.dispose();
    controller.dispose();
    super.dispose();
  }

  initTextController() {
    dateCtl.text =
        "${widget.pickerModel.getMonthName()} ${widget.pickerModel.getYear()}";
  }

  void other() {
    widget.pickerModel.setArrowType("prev");
    controller.forward();
    isSlideAnimated = true;
    widget.pickerModel.changeMonth('other');
    monthSlide = true;
    yearSlide = false;
    initTextController();
    setState(() {});
  }

  void _changeMonthPrev() {
    widget.pickerModel.setArrowType("prev");
    controller.forward();
    isSlideAnimated = true;
    widget.pickerModel.changeMonth('prev');
    monthSlide = true;
    yearSlide = false;
    initTextController();
    setState(() {});
  }

  void _changeMonthNext() {
    widget.pickerModel.setArrowType("next");
    controller.forward();
    isSlideAnimated = false;
    widget.pickerModel.changeMonth('next');
    monthSlide = true;
    yearSlide = false;
    initTextController();
    setState(() {});
  }

  void _changeYearPrev() {
    widget.pickerModel.setArrowType("prev");
    controller.forward();
    isSlideAnimated = true;
    widget.pickerModel.changeYear('prev');
    monthSlide = false;
    yearSlide = true;
    initTextController();
    setState(() {});
  }

  void _changeYearNext() {
    widget.pickerModel.setArrowType("next");
    controller.forward();
    isSlideAnimated = false;
    widget.pickerModel.changeYear('next');
    monthSlide = false;
    yearSlide = true;
    initTextController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.pickerModel.headerType == HeaderType.mix)
              TodayHeaderWidget(
                //MixedHeaderWidget
                controller: controller,
                theme: widget.theme,
                pickerModel: widget.pickerModel,
                changeMonthPrev: _changeMonthPrev,
                changeMonthNext: _changeMonthNext,
                isSlideForward: isSlideAnimated,
              ),
            if (widget.pickerModel.headerType == HeaderType.seprated)
              SeparateHeaderWidget(
                  controller: controller,
                  theme: widget.theme,
                  pickerModel: widget.pickerModel,
                  changeMonthPrev: _changeMonthPrev,
                  changeMonthNext: _changeMonthNext,
                  changeYearPrev: _changeYearPrev,
                  changeYearNext: _changeYearNext,
                  isSlideForward: isSlideAnimated,
                  yearSlide: yearSlide,
                  monthSlide: monthSlide),
            if (widget.pickerModel.headerType == HeaderType.writable)
              CustomDateHeaderWidget(
                controller: controller,
                dateCtl: dateCtl,
                theme: widget.theme,
                pickerModel: widget.pickerModel,
                changeMonthPrev: _changeMonthPrev,
                changeYearPrev: _changeYearPrev,
                changeMonthNext: _changeMonthNext,
                changeYearNext: _changeYearNext,
                onSubmitted: other,
                isSlideForward: isSlideAnimated,
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
            dayOfWeekNameContainer(),
            daysTable(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: MainButtonWidget(
                theme: widget.theme,
                onConfirm: () {
                  widget.onConfirm(widget.pickerModel.selectDate());
                  Navigator.of(context).pop();
                },
                onNow: () {
                  widget.onConfirm(widget.pickerModel.getNow());
                  Navigator.of(context).pop();
                },
              ),
            ),
            // buildRowButton(),
          ],
        ),
      ),
    );
  }

  Widget daysTable() {
    return SwapPageBuilder(
      isSweeped: _isSweeped,
      dragUpdate: (value) {
        setState(() {
          _isSweeped = true;
          if (value == SwapDirection.left) {
            _changeMonthNext();
          }
          if (value == SwapDirection.reight) {
            _changeMonthPrev();
          }
        });
      },
      dragEnd: () {
        setState(() {
          _isSweeped = false;
        });
      },
      widget: DaysTable(
        pickerModel: widget.pickerModel,
        theme: widget.theme,
        controller: controller,
        isSlideAnimated: isSlideAnimated,
        onConfirm: widget.onConfirm,
      ),
    );
  }

// شنبه ، یکشنه ، دوشنبه
  Widget dayOfWeekNameContainer() {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.pickerModel.weekDaysName
            .map((day) => Container(
                  width: cellWidth,
                  height: cellHeight,
                  child: Center(
                    child: Text(day,
                        textAlign: TextAlign.center,
                        style: widget.theme.daysNameTextStyle),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class DaysTable extends StatefulWidget {
  final DatePickerModel pickerModel;
  final DatePickerTheme theme;
  final AnimationController controller;
  final bool isSlideAnimated;
  final DateChangedCallback onConfirm;

  const DaysTable({
    Key key,
    @required this.pickerModel,
    @required this.theme,
    @required this.controller,
    @required this.isSlideAnimated,
    this.onConfirm,
  }) : super(key: key);

  @override
  _DaysTableState createState() => _DaysTableState();
}

class _DaysTableState extends State<DaysTable> {
  final cellWidth = 50.0;
  final cellHeight = 35.0;
  List<Widget> allDaysWidget = [];
  List<Widget> chunkWeeksWidget = [];
  bool _isSlideAnimated = false;

  @override
  void initState() {
    widget.pickerModel.makeDays();
    makeDaysContainer();
    _isSlideAnimated = widget.isSlideAnimated;
    super.initState();
  }

  @override
  void didUpdateWidget(DaysTable oldWidget) {
    widget.pickerModel.makeDays();
    makeDaysContainer();
    _isSlideAnimated = widget.isSlideAnimated;
    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.pickerModel.arrowType == "next")
          _isSlideAnimated = true;
        else
          _isSlideAnimated = false;
      }
    });
    // setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  makeDaysContainer() {
    allDaysWidget = widget.pickerModel.allDaysOfTable.map((day) {
      return DayContainer(
        pickerModel: widget.pickerModel,
        theme: widget.theme,
        day: day,
        onTap: (value) {
          setState(() {
            makeDaysContainer();
          });
        },
      );
    }).toList();
    List chunkAllDays = partition(allDaysWidget, 7).toList();

    chunkWeeksWidget = chunkAllDays.map((week) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: week,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) => Transform(
          transform: Matrix4.translationValues(
              widget.controller.value * (_isSlideAnimated ? 300 : -300), 0, 0),
          child: Opacity(
            opacity: 1 - widget.controller.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: chunkWeeksWidget,
            ),
          ),
        ),
      ),
    );
  }
}
