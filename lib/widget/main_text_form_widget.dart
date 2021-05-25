import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTextFormWidget extends StatefulWidget {
  final String hintText;
  final List<TextInputFormatter> masks;
  final TextInputType keyboardType;

  const MainTextFormWidget({
    Key key,
    this.hintText = "",
    this.masks,
    this.keyboardType,
  }) : super(key: key);

  @override
  _MainTextFormWidgetState createState() => _MainTextFormWidgetState();
}

class _MainTextFormWidgetState extends State<MainTextFormWidget> {
  var dateCtl = TextEditingController();
  bool _isReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: dateCtl,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          inputFormatters: widget.masks,
          keyboardType: widget.keyboardType,
          showCursor: true,
          autofocus: true,
          readOnly: _isReadOnly,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            // counterText: '',
            hintText: widget.hintText,
            fillColor: Colors.white,
            // filled: true,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: BorderSide(
            //     color: Colors.green,
            //     width: 1,
            //   ),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: BorderSide(
            //     color: Color(0xFFd3d3d3),
            //     width: 1,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: BorderSide(
            //     color: Color(0xFFd3d3d3),
            //     width: 1,
            //   ),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: BorderSide(
            //     color: Color(0xFFC20411),
            //     width: 1,
            //   ),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(5),
            //   borderSide: BorderSide(
            //     color: Color(0xFFC20411),
            //     width: 1,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
