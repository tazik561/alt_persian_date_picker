
  

# A persian (farsi,shamsi) date picker for flutter, inspired by material datetime picker.

  

[![pub package](https://img.shields.io/pub/v/persian_datetime_picker.svg?color=%23e67e22&label=pub&logo=persian_datetime_picker)](https://pub.dartlang.org/packages/alt_persian_datetime_picker)

  

A Flutter persian date picker inspired by material datetime picker and based on [shamsi_date](https://pub.dartlang.org/packages/shamsi_date).

  

You can pick date / range date /  Month / Year .

  
  

# Screenshots

|||||||
| ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
|![]( images/month_picker.png) |![]( images/year_picker.png) |![]( images/date_picker.png) |![]( images/date_picker_editable.png) |![]( images/date_picker_ranged.png) |![]( images/date_picker_seprate.png) |

  
  

## Usage

  

Add it to your pubspec.yaml file:

  

```yaml

dependencies:

alt_persian_datetime_picker: version

```

  

In your library add the following import:

  

```dart

import 'package:alt_persian_date_picker/alt_persian_date_picker.dart';

```

  

Here is an example how to use:

  

```dart

            TextButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  PickerEnum.month,
                  theme: DatePickerTheme(
                      noneSelectedItemColor: Colors.white,
                      selectedItemColor: Colors.greenAccent,
                      disableItemColor: Colors.redAccent),
                  pickerModel: MonthPickerModel(
                    startSelectedInitDate: 4,
                    disables: [1, 5],
                  ),
                  onConfirm: (time) {
                    print("Selected month is $time");
                    _showToast(time);
                  },
                );
              },
              child: Text("ماه"),
            ),
```

## Date time picker parameters and events

| Parameter  | Type | Default | Description |
|-------------------------|---------------------|-----------------------------------------|------------------------------------------------------------------------------                                                                            |
| type| `PickerEnum`| Has 4 values(`month`,`year`,`date`,`rangedate`)|
| headerType| `HeaderType`| Has 3 values(`seprated `,`mix`,`writable`)|
| disable| `String` or `List<String>`|null| Disable dates |
| theme| `DatePickerTheme`| | You can add your style to each part of date picker |
| onConfirm| `Function(String)`| | This event return a String date |



##Pull request and feedback are always appreciated.
###Contact me with `ali.tazik@gmail.com`.

#f create -t app ./example