<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


## Date Picker Dropdown
[![Pub](https://img.shields.io/badge/pub-v0.1.1-green)](https://pub.dev/packages/datepicker_dropdown)

A Date picker Dropdown for Flutter with customizable options.

## Features

<p float="left">

<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/mainview.png" alt="Main View" width="200"/>
<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/monthview.png" alt="monthview" width="200"/>
<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/dateview.png" alt="dateview" width="200"/>
<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/master/yearview.png" alt="yearview" width="200"/>
</p>

## Getting started

```dart
DropdownDatePicker()
```

## Usage

For more [Example](https://github.com/Robertrobinson777/dropdown_date_picker/tree/master/example)

```dart
 DropdownDatePicker(
              dateformatorder: OrderFormat.YDM, // default is myd
              inputDecoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))), // optional
              isDropdownHideUnderline: true, // optional
              isFormValidator: true, // optional
              startYear: 1900, // optional
              endYear: 2020, // optional
              width: 10, // optional
              // selectedDay: 14, // optional
              selectedMonth: 10, // optional
              selectedYear: 1993, // optional
              onChangedDay: (value) => print('onChangedDay: $value'),
              onChangedMonth: (value) => print('onChangedMonth: $value'),
              onChangedYear: (value) => print('onChangedYear: $value'),
              //boxDecoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 1.0)), // optional
              // showDay: false,// optional
              // dayFlex: 2,// optional
              // locale: "zh_CN",// optional
              // hintDay: 'Day', // optional
              // hintMonth: 'Month', // optional
              // hintYear: 'Year', // optional
              // hintTextStyle: TextStyle(color: Colors.grey), // optional
            ),
```

## GitHub source code

If you're interested on the code (feel free to modify it anyway you want), you can find it here: [https://github.com/Robertrobinson777/dropdown_date_picker](https://github.com/Robertrobinson777/dropdown_date_picker)

## Support

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/robertrobinsonr)
