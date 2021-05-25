import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:alt_persian_date_picker/src/partition.dart';
import 'package:alt_persian_date_picker/widget/main_button_widget.dart';
import 'package:flutter/material.dart';

class AltYearPicker extends StatefulWidget {
  final YearPickerModel pickerModel;
  final DatePickerTheme theme;
  final DateChangedCallback onConfirm;

  const AltYearPicker({
    Key key,
    this.pickerModel,
    this.theme,
    this.onConfirm,
  }) : super(key: key);
  @override
  _AltYearPickerState createState() => _AltYearPickerState();
}

class _AltYearPickerState extends State<AltYearPicker>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController fadeController;
  Animation<double> animation;
  bool isSlideAnimated = false;
  bool isSweeped = false;
  List<Widget> yearsWidget = [];

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    fadeController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
          if (widget.pickerModel.arrowType == "next")
            isSlideAnimated = true;
          else
            isSlideAnimated = false;
        }
      });
    super.initState();
    fadeController.forward();
  }

  @override
  void dispose() {
    fadeController.dispose();
    controller.dispose();
    super.dispose();
  }

  void _changePrev() {
    widget.pickerModel.setArrowType("prev");
    controller.forward();
    isSlideAnimated = true;
    widget.pickerModel.changePrevYear();
    setState(() {});
  }

  void _changeNext() {
    widget.pickerModel.setArrowType("next");
    controller.forward();
    isSlideAnimated = false;
    widget.pickerModel.changeNextYear();
    setState(() {});
  }

  void makeDateNameWidgetList() {
    yearsWidget = widget.pickerModel.years
        .map((year) => GestureDetector(
              onTap: () {
                if (!widget.pickerModel.isDisable(year))
                  setState(() {
                    widget.pickerModel.setSelectedYear(year);
                  });
              },
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: widget.pickerModel.isDisable(year)
                      ? widget.theme.disableItemColor
                      : widget.pickerModel.isSelectedYear(year)
                          ? widget.theme.selectedItemColor
                          : widget.pickerModel.startSelectedInitDate == year
                              ? Colors.grey[300]
                              : widget.theme.noneSelectedItemColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: widget.pickerModel.startSelectedInitDate == year
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
                      '$year',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color:
                              widget.pickerModel.startSelectedInitDate == year
                                  ? widget.theme.selectedText
                                  : widget.theme.noneSelectedText,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    makeDateNameWidgetList();

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
                titleRow(),
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
                contentWidget(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: MainButtonWidget(
                    theme: widget.theme,
                    onConfirm: () {
                      widget.pickerModel.startSelectedInitDate.toString();
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

  GestureDetector contentWidget() {
    List chunks = partition(yearsWidget, 4).toList();
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        isSweeped = false;
      },
      onHorizontalDragUpdate: (details) {
        double sensitivity = 8.5;
        if (details.delta.dx >= sensitivity) {
          if (!isSweeped) {
            isSweeped = true;
            _changePrev();
          }
        } else if (details.delta.dx <= -sensitivity) {
          if (!isSweeped) {
            isSweeped = true;
            _changeNext();
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: chunks.map((row) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform(
                transform: Matrix4.translationValues(
                    animation.value * (isSlideAnimated ? 300 : -300), 0, 0),
                child: Opacity(
                  opacity: 1 - animation.value,
                  child: AnimatedBuilder(
                    animation: fadeController,
                    builder: (context, child) => Opacity(
                      opacity: fadeController.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: row,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Row titleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            _changePrev();
          },
          icon: Icon(Icons.chevron_left),
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) => GestureDetector(
            onTap: () {},
            child: Transform(
              transform: Matrix4.translationValues(
                  animation.value * (isSlideAnimated ? 100 : -100), 0, 0),
              child: Opacity(
                opacity: 1 - animation.value,
                child: SizedBox(
                  width: 50,
                  child: Center(
                    child: Text(
                      '${widget.pickerModel.startSelectedInitDate}',
                      textAlign: TextAlign.right,
                      style: widget.theme.headerStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _changeNext();
          },
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
