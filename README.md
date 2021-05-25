
  

# A persian (farsi,shamsi) date picker for flutter, inspired by material datetime picker.

  

A Flutter persian date picker inspired by material datetime picker and based on [shamsi_date](https://pub.dartlang.org/packages/shamsi_date).

  

You can pick date / range date /  Month / Year .

  
  

# Screenshots

|||||||
| ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
|
![](https://github.com/tazik561/alt_persian_date_picker/raw/main/month_picker.png) |
![](https://github.com/tazik561/alt_persian_date_picker/blob/main/year_picker.png) |
![](https://github.com/tazik561/alt_persian_date_picker/blob/main/date_picker.png) |
![](https://github.com/tazik561/alt_persian_date_picker/raw/main/date_picker_editable.png) |
![](https://github.com/tazik561/alt_persian_date_picker/blob/main/date_picker_seprate.png) |
![](https://github.com/tazik561/alt_persian_date_picker/blob/main/date_picker_ranged.png) |

  
  

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

