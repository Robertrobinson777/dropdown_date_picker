# Date Picker Dropdown

[![pub package](https://img.shields.io/pub/v/datepicker_dropdown.svg)](https://pub.dev/packages/datepicker_dropdown)

A customizable dropdown date picker for Flutter with support for multiple field orders, validation, localization, and form-friendly callbacks.

Web demo: [datepicker.robertrobinson.in](https://datepicker.robertrobinson.in/)

## Features

- Day, month, and year dropdowns with configurable order
- Optional form validation for each field
- Locale-specific month labels
- Configurable year range, spacing, flex, styles, and decorations
- Safe handling of invalid date combinations such as `31 February`
- Controlled-widget support when the parent rebuilds with new selected values

<p float="left">
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/mainview.png" alt="Main View" width="200"/>
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/monthview.png" alt="Month View" width="200"/>
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/dateview.png" alt="Date View" width="200"/>
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/yearview.png" alt="Year View" width="200"/>
</p>

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  datepicker_dropdown: ^1.0.2
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';

class BirthDateField extends StatefulWidget {
  const BirthDateField({super.key});

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  int? _day;
  int? _month;
  int? _year;

  @override
  Widget build(BuildContext context) {
    return DropdownDatePicker(
      dateFormatOrder: OrderFormat.ydm,
      startYear: 1900,
      endYear: DateTime.now().year,
      selectedDay: _day,
      selectedMonth: _month,
      selectedYear: _year,
      onChangedDay: (String? value) {
        setState(() {
          _day = int.tryParse(value ?? '');
        });
      },
      onChangedMonth: (String? value) {
        setState(() {
          _month = int.tryParse(value ?? '');
        });
      },
      onChangedYear: (String? value) {
        setState(() {
          _year = int.tryParse(value ?? '');
        });
      },
    );
  }
}
```

## Form Example

```dart
DropdownDatePicker(
  dateFormatOrder: OrderFormat.mdy,
  isFormValidator: true,
  isDropdownHideUnderline: true,
  startYear: 1900,
  endYear: 2025,
  hintDay: 'Day',
  hintMonth: 'Month',
  hintYear: 'Year',
  inputDecoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  ),
  onChangedDay: (String? value) {
    debugPrint('day: $value');
  },
  onChangedMonth: (String? value) {
    debugPrint('month: $value');
  },
  onChangedYear: (String? value) {
    debugPrint('year: $value');
  },
)
```

## Notes

- `dateFormatOrder` is the preferred property name.
- `dateformatorder` is still supported as a deprecated backwards-compatible alias.
- If the current day becomes invalid after a month or year change, the widget automatically adjusts it to the last valid day and notifies `onChangedDay`.
- The widget syncs correctly when the parent rebuilds with new `selectedDay`, `selectedMonth`, or `selectedYear` values.

## Supported Locales

`en`, `en_abbv`, `num`, `ar`, `de_DE`, `el_GR`, `es_ES`, `fr_FR`, `gu_IN`, `hi_IN`, `id_ID`, `it_IT`, `ja`, `kn_IN`, `ko_KR`, `ml_IN`, `mr_IN`, `nl_NL`, `pl_PL`, `pt_BR`, `ru_RU`, `sv_SE`, `ta_IN`, `te_IN`, `th`, `tr`, `vi`, `zh_CN`

## Example App

See the example app in [`example/lib/main.dart`](example/lib/main.dart) for a complete integration.

## Repository

Source code: [github.com/Robertrobinson777/dropdown_date_picker](https://github.com/Robertrobinson777/dropdown_date_picker)

## Support

[![Buy Me A Coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/robertrobinsonr)
