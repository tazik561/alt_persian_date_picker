import 'package:flutter/material.dart';

enum SwapDirection { left, reight }

// ignore: must_be_immutable
class SwapPageBuilder extends StatelessWidget {
  final ValueChanged<SwapDirection> dragUpdate;
  final VoidCallback dragEnd;
  final Widget widget;

  SwapPageBuilder({
    Key key,
    bool isSweeped = false,
    @required this.dragUpdate,
    @required this.dragEnd,
    @required this.widget,
  })  : _isSweeped = isSweeped,
        super(key: key);

  bool _isSweeped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        double sensitivity = 8.0;
        if (details.delta.dx >= sensitivity) {
          if (!_isSweeped) {
            _isSweeped = true;
            dragUpdate(SwapDirection.reight);
          }
        } else if (details.delta.dx <= -sensitivity) {
          if (!_isSweeped) {
            _isSweeped = true;
            dragUpdate(SwapDirection.left);
          }
        }
      },
      onHorizontalDragEnd: (details) {
        dragEnd();
      },
      child: widget,
    );
  }
}
