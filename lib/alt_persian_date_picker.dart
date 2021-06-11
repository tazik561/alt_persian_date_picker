library alt_persian_date_picker;

export 'package:alt_persian_date_picker/src/picker_enum.dart';
export 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
export 'package:alt_persian_date_picker/src/date_model.dart';

import 'package:alt_persian_date_picker/pages/alt_date_picker.dart';
import 'package:alt_persian_date_picker/pages/alt_month_picker.dart';
import 'package:alt_persian_date_picker/pages/alt_timeline_picker.dart';
import 'package:alt_persian_date_picker/pages/alt_year_picker.dart';
import 'package:alt_persian_date_picker/src/date_model.dart';
import 'package:alt_persian_date_picker/src/datetime_picker_theme.dart';
import 'package:alt_persian_date_picker/src/picker_enum.dart';
import 'package:flutter/material.dart';

typedef DateChangedCallback(String time);
typedef DateCancelledCallback();

class DatePicker {
  static Future showDatePicker(
    BuildContext context,
    PickerEnum type, {
    DateChangedCallback onConfirm,
    DateCancelledCallback onCancel,
    DatePickerTheme theme,
    BasePickerModel pickerModel,
  }) async {
    return Navigator.push(
      context,
      _DatePickerRoute(
        type: type,
        onConfirm: onConfirm,
        onCancel: onCancel,
        theme: theme,
        pickerModel: pickerModel,
      ),
    );
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  final PickerEnum type;
  final DateChangedCallback onConfirm;
  final DateCancelledCallback onCancel;
  final BasePickerModel _pickerModel;
  final DatePickerTheme _theme;
  AnimationController _animationController;

  _DatePickerRoute({
    this.type = PickerEnum.month,
    this.onConfirm,
    this.onCancel,
    RouteSettings settings,
    BasePickerModel pickerModel,
    DatePickerTheme theme,
  })  : this._pickerModel = pickerModel ?? MonthPickerModel(),
        this._theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => "ماه های سال";

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        type: type,
        route: this,
        pickerModel: _pickerModel,
        onConfirm: onConfirm,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class _DatePickerComponent extends StatefulWidget {
  final _DatePickerRoute route;
  final PickerEnum type;
  final BasePickerModel pickerModel;
  final DateChangedCallback onConfirm;

  const _DatePickerComponent({
    Key key,
    this.route,
    this.type,
    this.pickerModel,
    this.onConfirm,
  }) : super(key: key);

  @override
  __DatePickerComponentState createState() => __DatePickerComponentState();
}

class __DatePickerComponentState extends State<_DatePickerComponent> {
  DatePickerTheme theme;

  @override
  void initState() {
    super.initState();
    theme = widget.route._theme;
  }

  Widget datePicker() {
    switch (widget.type) {
      case PickerEnum.month:
        return AltMonthPicker(
            pickerModel: widget.pickerModel,
            theme: theme,
            onConfirm: widget.onConfirm);
        break;
      case PickerEnum.year:
        return AltYearPicker(
            pickerModel: widget.pickerModel,
            theme: theme,
            onConfirm: widget.onConfirm);
        break;
      case PickerEnum.date:
        return AltDatePicker(
          pickerModel: widget.pickerModel,
          theme: theme,
          onConfirm: widget.onConfirm,
        );
        break;
      case PickerEnum.rangedate:
        return AltDatePicker(
          pickerModel: widget.pickerModel,
          theme: theme,
          onConfirm: widget.onConfirm,
        );
        break;
      case PickerEnum.timeline:
        return AltTimeLinePicker(
          pickerModel: widget.pickerModel,
          theme: theme,
          onConfirm: widget.onConfirm,
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideBuilder(
      alignment: Alignment.bottomCenter,
      animation: widget.route.animation,
      builder: (context, child, a) => child,
      // child:
      // FractionallySizedBox(
      // heightFactor: 0.5,
      // widthFactor: 1.0,
      child: Material(
        color: theme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 1.0,
        child: datePicker(),
      ),
      // ),
    );
  }
}

class SlideBuilder extends AnimatedWidget {
  final Animation<double> animation;
  final Widget Function(
      BuildContext context, Widget child, Animation<double> animation) builder;
  final Alignment alignment;
  final Alignment innerAlignment;
  final Widget child;

  SlideBuilder({
    Key key,
    @required this.animation,
    @required this.alignment,
    @required this.builder,
    this.child,
  })  : innerAlignment = -alignment,
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final a = Alignment.lerp(Alignment.center, alignment, animation.value);
    final widthFactor = alignment.x == 0 ? null : a.x.abs();
    final heightFactor = alignment.y == 0 ? null : a.y.abs();
    return ClipRect(
      child: Align(
        alignment: alignment,
        child: Align(
          alignment: innerAlignment,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: builder(context, child, animation),
        ),
      ),
    );
  }
}
