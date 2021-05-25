import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';
import 'package:alt_persian_date_picker/widget/main_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WritableDateFormWidget extends StatefulWidget {
  final DatePickerTheme theme;
  final TextEditingController dateCtl;
  final ValueChanged<String> onSubmitted;

  const WritableDateFormWidget({
    Key key,
    @required this.theme,
    this.dateCtl,
    @required this.onSubmitted,
  }) : super(key: key);

  @override
  _WritableDateFormWidgetState createState() => _WritableDateFormWidgetState();
}

class _WritableDateFormWidgetState extends State<WritableDateFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: 120,
          height: 40,
          child: TextFormField(
            textAlign: TextAlign.center,
            onTap: () {
              setState(() {
                _isReadOnly = false;
              });
            },
            controller: widget.dateCtl,
            style: widget.theme.headerStyle,
            inputFormatters: [
              LengthLimitingTextInputFormatter(13),
              FilteringTextInputFormatter.allow(
                RegExp(
                    '[\u0600-\u06FF\uFB8A\u067E\u0686\u06AF\u0020\u2000-\u200F\u2028-\u202F]'),
              ),
            ],
            keyboardType: TextInputType.name,
            showCursor: true,
            autofocus: true,
            readOnly: _isReadOnly,
            onFieldSubmitted: (value) {
              if (_formKey.currentState.validate()) widget.onSubmitted(value);
            },
            validator: (value) {
              if (value.isEmpty) return "نباید خالی باشد";
              return null;
            },
            onChanged: (value) {
              _formKey.currentState.validate();
            },
            decoration: widget.theme.inputDecoration == null
                ? InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    // counterText: '',
                    hintText: "تاریخ",
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
                  )
                : widget.theme.inputDecoration,
          ),
        ),
      ),
    );
  }
}
