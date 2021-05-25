import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Migrate DiagnosticableMixin to Diagnosticable until
// https://github.com/flutter/flutter/pull/51495 makes it into stable (v1.15.21)
class DatePickerTheme with DiagnosticableTreeMixin {
  final TextStyle cancelStyle;
  final TextStyle nowStyle;
  final TextStyle doneStyle;
  final Color buttonColor;
  final Color noneSelectedItemColor;
  final Color selectedItemColor;
  final Color disableItemColor;
  final Color noneSelectedText;
  final Color selectedText;
  final Color backgroundColor;
  final TextStyle headerStyle;
  final TextStyle daysNameTextStyle;
  final TextStyle disablesTextStyle;
  final TextStyle daysNumberTextStyle;
  final InputDecoration inputDecoration;

  final double containerHeight;
  // final double titleHeight;
  // final double itemHeight;

  const DatePickerTheme({
    this.cancelStyle = const TextStyle(color: Colors.black54, fontSize: 14),
    this.nowStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.doneStyle = const TextStyle(color: Colors.white, fontSize: 14),
    this.headerStyle = const TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    this.daysNameTextStyle = const TextStyle(
        color: Color(0xFFabb9c4), fontSize: 12, fontWeight: FontWeight.w500),
    this.disablesTextStyle = const TextStyle(
        color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),
    this.daysNumberTextStyle = const TextStyle(
        color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
    this.buttonColor = Colors.greenAccent,
    this.backgroundColor = Colors.white,
    this.disableItemColor = Colors.grey,
    this.noneSelectedItemColor = Colors.white,
    this.selectedItemColor = Colors.greenAccent,
    this.noneSelectedText = Colors.black,
    this.selectedText = Colors.white,
    this.containerHeight = 324.0,
    this.inputDecoration = const InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      hintText: "ماه و سال",
      fillColor: Colors.white,
      hintStyle: TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
      errorStyle: TextStyle(fontSize: 12.0, color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  });
}
