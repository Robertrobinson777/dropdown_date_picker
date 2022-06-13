// ignore_for_file: non_constant_identifier_names

library datepicker_dropdown;

import 'package:flutter/material.dart';

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class DropdownDatePicker extends StatefulWidget {
  ///DropDown select text style
  final TextStyle? textStyle;

  ///DropDown container box decoration
  final BoxDecoration? boxDecoration;

  ///DropDown expand icon
  final Icon? icon;

  ///Start year for date picker
  ///Default is 1900
  final int? startYear;

  ///End year for date picker
  ///Default is Current year
  final int? endYear;

  ///width between each drop down
  ///Default is 12.0
  final double width;

  ///Return selected date
  ValueChanged<String?>? onChangedDay;

  ///Return selected month
  ValueChanged<String?>? onChangedMonth;

  ///Return selected year
  ValueChanged<String?>? onChangedYear;

  ///Error message for Date
  String errorDay;

  ///Error message for Month
  String errorMonth;

  ///Error message for Year
  String errorYear;

  ///Is Form validator enabled
  ///Default is false
  final bool isFormValidator;

  ///Is Expanded for dropdown
  ///Default is true
  final bool isExpanded;

  ///Selected Day between 1 to 31
  final int? selectedDay;

  ///Selected Month between 1 to 12
  final int? selectedMonth;

  ///Selected Year between startYear and endYear
  final int? selectedYear;

  ///Default [isDropdownHideUnderline] = false. Wrap with DropdownHideUnderline for the dropdown to hide the underline.
  final bool isDropdownHideUnderline;

  /// auther: xiaoshuyui
  ///
  /// ------
  /// locale
  ///
  /// default `en`
  ///
  /// support `zh_CN`
  final String locale;

  /// auther: xiaoshuyui
  ///
  /// ------
  /// picker order
  ///
  /// Parameter type: Map<String,int>
  ///
  /// key is picker type, ["month","year","day"]
  ///
  /// value is Expanded widget flex
  ///
  /// defalut {"month": 4, "day": 5, "year": 3}
  Map<String, int> pickerOrder;

  DropdownDatePicker(
      {Key? key,
      this.textStyle,
      this.boxDecoration,
      this.icon,
      this.startYear,
      this.endYear,
      this.width = 12.0,
      this.onChangedDay,
      this.onChangedMonth,
      this.onChangedYear,
      this.isDropdownHideUnderline = false,
      this.errorDay = 'Please select day',
      this.errorMonth = 'Please select month',
      this.errorYear = 'Please select year',
      this.isFormValidator = false,
      this.isExpanded = true,
      this.selectedDay,
      this.selectedMonth,
      this.selectedYear,
      this.locale = 'en',
      this.pickerOrder = const {"month": 4, "day": 5, "year": 3}})
      : assert(["en", "zh_CN"].contains(locale)),
        assert(pickerOrder.length <= 3 &&
            (pickerOrder.keys.contains("year") ||
                pickerOrder.keys.contains("day") ||
                pickerOrder.keys.contains("month"))),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  var monthselVal = '';
  var dayselVal = '';
  var yearselVal = '';
  int daysIn = 32;
  late List listdates = [];
  late List listyears = [];
  late List<dynamic> listMonths = [];

  @override
  void initState() {
    super.initState();
    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    monthselVal =
        widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal =
        widget.selectedYear != null ? widget.selectedYear.toString() : '';
    listdates = Iterable<int>.generate(daysIn).skip(1).toList();
    listyears =
        Iterable<int>.generate((widget.endYear ?? DateTime.now().year) + 1)
            .skip(widget.startYear ?? 1900)
            .toList()
            .reversed
            .toList();

    if (widget.locale == "zh_CN") {
      listMonths = listMonths_zh_CN;
    } else {
      listMonths = listMonths_en;
    }
  }

  ///Month selection dropdown function
  monthSelected(value) {
    widget.onChangedMonth!(value);
    monthselVal = value;
    int days = daysInMonth(
        yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
        int.parse(value));
    listdates = Iterable<int>.generate(days + 1).skip(1).toList();
    checkDates(days);
    update();
  }

  ///check dates for selected month and year
  void checkDates(days) {
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        widget.onChangedDay!('');
        update();
      }
    }
  }

  ///find days in month and year
  int daysInMonth(year, month) => DateTimeRange(
          start: DateTime(year, month, 1), end: DateTime(year, month + 1))
      .duration
      .inDays;

  ///day selection dropdown function
  daysSelected(value) {
    widget.onChangedDay!(value);
    dayselVal = value;
    update();
  }

  ///year selection dropdown function
  yearsSelected(value) {
    widget.onChangedYear!(value);
    yearselVal = value;
    if (monthselVal != '') {
      int days = daysInMonth(
          yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
          int.parse(monthselVal));
      listdates = Iterable<int>.generate(days + 1).skip(1).toList();
      checkDates(days);
      update();
    }
    update();
  }

  ///list of months , en
  List<dynamic> listMonths_en = [
    {"id": 1, "value": "January"},
    {"id": 2, "value": "February"},
    {"id": 3, "value": "March"},
    {"id": 4, "value": "April"},
    {"id": 5, "value": "May"},
    {"id": 6, "value": "June"},
    {"id": 7, "value": "July"},
    {"id": 8, "value": "August"},
    {"id": 9, "value": "September"},
    {"id": 10, "value": "October"},
    {"id": 11, "value": "November"},
    {"id": 12, "value": "December"}
  ];

  ///list of months , zh_CN
  List<dynamic> listMonths_zh_CN = [
    {"id": 1, "value": "1月"},
    {"id": 2, "value": "2月"},
    {"id": 3, "value": "3月"},
    {"id": 4, "value": "4月"},
    {"id": 5, "value": "5月"},
    {"id": 6, "value": "6月"},
    {"id": 7, "value": "7月"},
    {"id": 8, "value": "8月"},
    {"id": 9, "value": "9月"},
    {"id": 10, "value": "10月"},
    {"id": 11, "value": "11月"},
    {"id": 12, "value": "12月"}
  ];

  ///update function
  update() {
    setState(() {});
  }

  Widget buildPicker(String pickerType, int flex) {
    switch (pickerType) {
      case "month":
        return Expanded(
          flex: flex,
          child: Container(
            decoration: widget.boxDecoration ?? const BoxDecoration(),
            child: SizedBox(
              // height: 49,
              child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: monthDropdown(),
                      )
                    : monthDropdown(),
              ),
            ),
          ),
        );
      case "year":
        return Expanded(
          flex: flex,
          child: Container(
            decoration: widget.boxDecoration ?? const BoxDecoration(),
            child: SizedBox(
              // height: 49,
              child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: yearDropdown(),
                      )
                    : yearDropdown(),
              ),
            ),
          ),
        );
      case "day":
        return Expanded(
          flex: flex,
          child: Container(
            decoration: widget.boxDecoration ?? const BoxDecoration(),
            child: SizedBox(
              // height: 49,
              child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: dayDropdown(),
                      )
                    : dayDropdown(),
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  List<Widget> buildPickers() {
    List<Widget> results = [];
    for (int i = 0; i < widget.pickerOrder.entries.length; i++) {
      Widget picker = buildPicker(widget.pickerOrder.entries.elementAt(i).key,
          widget.pickerOrder.entries.elementAt(i).value);

      if (picker.runtimeType != Container) {
        results.add(picker);
      }
    }

    if (results.length == 2) {
      results.insert(1, w(widget.width));
      return results;
    }

    if (results.length == 3) {
      results.insert(1, w(widget.width));
      results.insert(3, w(widget.width));
      return results;
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildPickers(),
    );
  }

  ///month dropdown
  DropdownButtonFormField<String> monthDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.isDropdownHideUnderline ? removeUnderline() : null,
        isExpanded: widget.isExpanded,
        hint: const Text('Month'),
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: monthselVal == '' ? null : monthselVal,
        onChanged: (value) {
          monthSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorMonth
                  : null
              : null;
        },
        items: listMonths.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"].toString(),
            child: Text(
              item["value"].toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///Remove underline from dropdown
  InputDecoration removeUnderline() {
    return const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  ///year dropdown
  DropdownButtonFormField<String> yearDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.isDropdownHideUnderline ? removeUnderline() : null,
        hint: const Text('Year'),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: yearselVal == '' ? null : yearselVal,
        onChanged: (value) {
          yearsSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorYear
                  : null
              : null;
        },
        items: listyears.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              item.toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.isDropdownHideUnderline ? removeUnderline() : null,
        hint: const Text('Days'),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: dayselVal == '' ? null : dayselVal,
        onChanged: (value) {
          daysSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorDay
                  : null
              : null;
        },
        items: listdates.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList());
  }

  ///sizedbox for width
  Widget w(double count) => SizedBox(
        width: count,
      );
}
