/// A widget that provides a dropdown date picker with customizable options.
///
/// The [DropdownDatePicker] widget allows users to select a date using dropdown menus for day, month, and year.
/// It supports various customization options such as text style, box decoration, input decoration, icons, and more.
///
/// The widget also supports localization for different languages and date formats.
///
/// Example usage:
/// ```dart
/// DropdownDatePicker(
///   startYear: 2000,
///   endYear: 2025,
///   selectedDay: 15,
///   selectedMonth: 6,
///   selectedYear: 2021,
///   locale: 'en',
///   dateformatorder: OrderFormat.MDY,
///   onChangedDay: (value) {
///     print('Selected day: $value');
///   },
///   onChangedMonth: (value) {
///     print('Selected month: $value');
///   },
///   onChangedYear: (value) {
///     print('Selected year: $value');
///   },
/// )
/// ```
///
/// The [DropdownDatePicker] widget has the following properties:
///
/// * [textStyle]: The text style for the dropdown select text.
/// * [boxDecoration]: The box decoration for the dropdown container.
/// * [inputDecoration]: The input decoration for the dropdown.
/// * [icon]: The expand icon for the dropdown.
/// * [startYear]: The start year for the date picker (default is 1900).
/// * [endYear]: The end year for the date picker (default is the current year).
/// * [width]: The width between each dropdown (default is 12.0).
/// * [menuHeight]: The height of the dropdown menu.
/// * [onChangedDay]: Callback for when the selected day changes.
/// * [onChangedMonth]: Callback for when the selected month changes.
/// * [onChangedYear]: Callback for when the selected year changes.
/// * [errorDay]: Error message for the day dropdown (default is 'Please select day').
/// * [errorMonth]: Error message for the month dropdown (default is 'Please select month').
/// * [errorYear]: Error message for the year dropdown (default is 'Please select year').
/// * [hintMonth]: Hint text for the month dropdown (default is 'Month').
/// * [hintYear]: Hint text for the year dropdown (default is 'Year').
/// * [hintDay]: Hint text for the day dropdown (default is 'Day').
/// * [hintTextStyle]: The text style for the hint text.
/// * [isFormValidator]: Whether form validation is enabled (default is false).
/// * [isExpanded]: Whether the dropdown is expanded (default is true).
/// * [selectedDay]: The initially selected day.
/// * [selectedMonth]: The initially selected month.
/// * [selectedYear]: The initially selected year.
/// * [isDropdownHideUnderline]: Whether to hide the underline of the dropdown (default is false).
/// * [locale]: The locale for the dropdown (default is 'en').
/// * [showYear]: Whether to show the year dropdown (default is true).
/// * [showMonth]: Whether to show the month dropdown (default is true).
/// * [showDay]: Whether to show the day dropdown (default is true).
/// * [monthFlex]: The flex value for the month dropdown (default is 2).
/// * [dayFlex]: The flex value for the day dropdown (default is 1).
/// * [yearFlex]: The flex value for the year dropdown (default is 2).
/// * [dateformatorder]: The order format for the date picker (default is [OrderFormat.MDY]).
// ignore_for_file: non_constant_identifier_names

library datepicker_dropdown;

import 'package:flutter/material.dart';

import 'list_of_months_ln.dart';
import 'order_format.dart';

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class DropdownDatePicker extends StatefulWidget {
  ///DropDown select text style
  final TextStyle? textStyle;

  ///DropDown container box decoration
  final BoxDecoration? boxDecoration;

  ///InputDecoration for DropDown
  final InputDecoration? inputDecoration;

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

  /// The height of the dropdown menu.
  ///
  /// This value can be null, in which case the default height will be used.
  final double? menuHeight;

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

  ///Hint for Month drop down
  ///Default is "Month"
  String hintMonth;

  ///Hint for Year drop down
  ///Default is "Year"
  String hintYear;

  ///Hint for Day drop down
  ///Default is "Day"
  String hintDay;

  ///Hint Textstyle for drop down
  TextStyle? hintTextStyle;

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

  /// locale
  /// default `en`
  /// support `zh_CN`
  /// support `it_IT`
  /// support fr_FR
  /// support de_DE
  /// suport es_ES
  /// suport ru_RU
  /// suport pt_BR
  /// support `id_ID`
  final String locale;

  /// default true
  bool showYear;
  bool showMonth;
  bool showDay;

  /// month expanded flex
  int monthFlex;

  /// day expanded flex
  int dayFlex;

  /// year expanded flex
  int yearFlex;

  ///Default [OrderFormat] = OrderFormat.MDY
  ///order format of datepicker is month, day, year
  OrderFormat dateformatorder;

  DropdownDatePicker({
    Key? key,
    this.textStyle,
    this.boxDecoration,
    this.inputDecoration,
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
    this.hintMonth = 'Month',
    this.hintDay = 'Day',
    this.hintYear = 'Year',
    this.hintTextStyle,
    this.isFormValidator = false,
    this.isExpanded = true,
    this.selectedDay,
    this.selectedMonth,
    this.selectedYear,
    this.locale = 'en',
    this.showDay = true,
    this.showMonth = true,
    this.showYear = true,
    this.monthFlex = 2,
    this.dayFlex = 1,
    this.yearFlex = 2,
    this.dateformatorder = OrderFormat.MDY,
    this.menuHeight,
  })  : assert([
          "en",
          "zh_CN",
          "it_IT",
          "de_DE",
          "tr",
          'fr_FR',
          'es_ES',
          'en_abbv',
          'num',
          "pt_BR",
          "ru_RU",
          "ja",
          "ko_KR",
          "ar",
          "nl_NL",
          "pl_PL",
          "th",
          "hi_IN",
          "sv_SE",
          "el_GR",
          "te_IN",
          "ta_IN",
          "ml_IN",
          "kn_IN",
          "mr_IN",
          "gu_IN",
          "vi",
          "id_ID",
        ].contains(locale)),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  var monthselVal = '';
  var dayselVal = '';
  var yearselVal = '';
  int daysIn = 31;
  late List<int> listdates = [];
  late List<int> listyears = [];
  late List<dynamic> listMonths = [];

  @override
  void initState() {
    super.initState();
    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    monthselVal =
        widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal =
        widget.selectedYear != null ? widget.selectedYear.toString() : '';
    listdates = List<int>.generate(daysIn, (index) => index + 1);
    listyears = List<int>.generate(
      (widget.endYear ?? DateTime.now().year) - (widget.startYear ?? 1900) + 1,
      (index) => (widget.startYear ?? 1900) + index,
    ).reversed.toList();

    // The code in this function is used to get the list of months in the user's locale.

    switch (widget.locale) {
      case "zh_CN":
        listMonths = listMonths_zh_CN;
        break;
      case "en_abbv":
        listMonths = listMonths_en_abbv;
        break;
      case "num":
        listMonths = listMonths_num;
        break;
      case "it_IT":
        listMonths = listMonths_it_IT;
        break;
      case "tr":
        listMonths = listMonths_tr;
        break;
      case "fr_FR":
        listMonths = listMonths_fr_FR;
        break;
      case "de_DE":
        listMonths = listMonths_de;
        break;
      case "es_ES":
        listMonths = listMonths_es_ES;
        break;
      case "pt_BR":
        listMonths = listMonths_pt_BR;
        break;
      case "ru_RU":
        listMonths = listMonths_ru_RU;
        break;
      case "ja":
        listMonths = listMonths_ja;
        break;
      case "ko_KR":
        listMonths = listMonths_ko_KR;
        break;
      case "ar":
        listMonths = listMonths_ar;
        break;
      case "nl_NL":
        listMonths = listMonths_nl_NL;
        break;
      case "pl_PL":
        listMonths = listMonths_pl_PL;
        break;
      case "vi":
        listMonths = listMonths_vi;
        break;
      case "th":
        listMonths = listMonths_th;
        break;
      case "hi_IN":
        listMonths = listMonths_hi_IN;
        break;
      case "sv_SE":
        listMonths = listMonths_sv_SE;
        break;
      case "el_GR":
        listMonths = listMonths_el_GR;
        break;
      case "te_IN":
        listMonths = listMonths_te;
        break;
      case "ta_IN":
        listMonths = listMonths_ta;
        break;
      case "ml_IN":
        listMonths = listMonths_ml;
        break;
      case "kn_IN":
        listMonths = listMonths_kn;
        break;
      case "mr_IN":
        listMonths = listMonths_mr;
        break;
      case "gu_IN":
        listMonths = listMonths_gu;
        break;
      case "id_ID":
        listMonths = listMonths_id_ID;
        break;
      case "en":
      default:
        listMonths = listMonths_en;
    }
  }

  ///Month selection dropdown function
  void monthSelected(String? value) {
    widget.onChangedMonth?.call(value);
    monthselVal = value ?? '';
    int days = daysInMonth(
      yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
      int.parse(value ?? '1'),
    );
    listdates = List<int>.generate(days, (index) => index + 1);
    checkDates(days);
    update();
  }

  void checkDates(int days) {
    // Check if the selected date is not null
    if (dayselVal != '') {
      // Check if the selected date is greater than the number of days
      if (int.parse(dayselVal) > days) {
        // If the selected date is greater than the number of days, clear the selected date
        dayselVal = '';
        widget.onChangedDay?.call(days.toString());
        update();
      }
    }
  }

  // Return the number of days in the given month.
  //
  // This function assumes that the month is in the range [1, 12].
  // If the month is out of range, this function throws a RangeError.
  int daysInMonth(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    return lastDayOfMonth.day;
  }

  // daysSelected is a function that is called when a user selects a day from the dropdown menu
  // The function takes a value as a parameter and calls the onChangedDay function in the parent widget
  // The onChangedDay function updates the day value in the parent widget and causes the widget to rebuild
  // value is the day that the user selected from the dropdown menu
  void daysSelected(String? value) {
    widget.onChangedDay?.call(value);
    dayselVal = value ?? '';
    update();
  }

  void yearsSelected(String? value) {
    widget.onChangedYear?.call(value);
    yearselVal = value ?? '';
    if (monthselVal != '') {
      int days = daysInMonth(
        yearselVal == '' ? DateTime.now().year : int.parse(yearselVal),
        int.parse(monthselVal),
      );
      listdates = List<int>.generate(days, (index) => index + 1);
      checkDates(days);
      update();
    }
    update();
  }

  ///update function
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dateformatorder) {
      case OrderFormat.DMY:
        return mainRow(day: 1, month: 2, year: 3);
      case OrderFormat.MDY:
        return mainRow(day: 2, month: 1, year: 3);
      case OrderFormat.YMD:
        return mainRow(day: 3, month: 2, year: 1);
      case OrderFormat.YDM:
        return mainRow(day: 2, month: 3, year: 1);
      case OrderFormat.MYD:
        return mainRow(day: 3, month: 1, year: 2);
      case OrderFormat.DYM:
        return mainRow(day: 1, month: 3, year: 2);
    }
  }

  Widget mainRow({int day = 2, int month = 1, int year = 3}) {
    return Row(
      children: [
        if (day == 1) dayWidget(),
        if (day == 1) w(widget.width),
        if (month == 1) monthWidget(),
        if (month == 1) w(widget.width),
        if (year == 1) yearWidget(),
        if (year == 1) w(widget.width),
        if (day == 2) dayWidget(),
        if (day == 2) w(widget.width),
        if (month == 2) monthWidget(),
        if (month == 2) w(widget.width),
        if (year == 2) yearWidget(),
        if (year == 2) w(widget.width),
        if (day == 3) dayWidget(),
        if (day == 3) w(widget.width),
        if (month == 3) monthWidget(),
        if (month == 3) w(widget.width),
        if (year == 3) yearWidget(),
        if (year == 3) w(widget.width),
      ],
    );
  }

  Widget mainColumn() {
    return Column(
      children: [
        monthWidget(),
        if (widget.showMonth) w(widget.width),
        dayWidget(),
        if (widget.showDay) w(widget.width),
        yearWidget(),
      ],
    );
  }

  Widget yearWidget() {
    return widget.showYear
        ? Expanded(
            flex: widget.yearFlex,
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
          )
        : const SizedBox.shrink();
  }

  Widget dayWidget() {
    return widget.showDay
        ? Expanded(
            flex: widget.dayFlex,
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
              )),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget monthWidget() {
    return widget.showMonth
        ? Expanded(
            flex: widget.monthFlex,
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
          )
        : const SizedBox.shrink();
  }

  ///month dropdown
  DropdownButtonFormField<String> monthDropdown() {
    return DropdownButtonFormField<String>(
      decoration: widget.inputDecoration ??
          (widget.isDropdownHideUnderline ? removeUnderline() : null),
      isExpanded: widget.isExpanded,
      hint: Text(widget.hintMonth, style: widget.hintTextStyle),
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      value: monthselVal.isEmpty ? null : monthselVal,
      menuMaxHeight: widget.menuHeight,
      onChanged: (value) {
        monthSelected(value);
      },
      validator: (value) {
        return widget.isFormValidator && value == null
            ? widget.errorMonth
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
                ),
          ),
        );
      }).toList(),
    );
  }

  ///Remove underline from dropdown
  InputDecoration removeUnderline() {
    return const InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    );
  }

  ///year dropdown
  DropdownButtonFormField<String> yearDropdown() {
    return DropdownButtonFormField<String>(
      decoration: widget.inputDecoration ??
          (widget.isDropdownHideUnderline ? removeUnderline() : null),
      hint: Text(widget.hintYear, style: widget.hintTextStyle),
      isExpanded: widget.isExpanded,
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      value: yearselVal.isEmpty ? null : yearselVal,
      menuMaxHeight: widget.menuHeight,
      onChanged: (value) {
        yearsSelected(value);
      },
      validator: (value) {
        return widget.isFormValidator && value == null
            ? widget.errorYear
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
                ),
          ),
        );
      }).toList(),
    );
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
      decoration: widget.inputDecoration ??
          (widget.isDropdownHideUnderline ? removeUnderline() : null),
      hint: Text(widget.hintDay, style: widget.hintTextStyle),
      isExpanded: widget.isExpanded,
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      value: dayselVal.isEmpty ? null : dayselVal,
      menuMaxHeight: widget.menuHeight,
      onChanged: (value) {
        daysSelected(value);
      },
      validator: (value) {
        return widget.isFormValidator && value == null ? widget.errorDay : null;
      },
      items: listdates.map((item) {
        return DropdownMenuItem<String>(
          value: item.toString(),
          child: Text(
            item.toString(),
            style: widget.textStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        );
      }).toList(),
    );
  }

  /* This code creates a blank space that is count pixels wide. */
  Widget w(double count) => SizedBox(width: count);
}
