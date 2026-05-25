library datepicker_dropdown;

import 'package:flutter/material.dart';

import 'list_of_months_ln.dart';
import 'order_format.dart';

const int _defaultStartYear = 1900;

/// A dropdown-based date picker with configurable ordering, styling, and locale.
class DropdownDatePicker extends StatefulWidget {
  /// DropDown select text style.
  final TextStyle? textStyle;

  /// DropDown container box decoration.
  final BoxDecoration? boxDecoration;

  /// Input decoration for the dropdown.
  final InputDecoration? inputDecoration;

  /// DropDown expand icon.
  final Icon? icon;

  /// Start year for date picker. Defaults to `1900`.
  final int? startYear;

  /// End year for date picker. Defaults to the current year.
  final int? endYear;

  /// Width between each drop down. Defaults to `12.0`.
  final double width;

  /// The height of the dropdown menu.
  final double? menuHeight;

  /// Called when the selected day changes.
  final ValueChanged<String?>? onChangedDay;

  /// Called when the selected month changes.
  final ValueChanged<String?>? onChangedMonth;

  /// Called when the selected year changes.
  final ValueChanged<String?>? onChangedYear;

  /// Error message for the day field.
  final String errorDay;

  /// Error message for the month field.
  final String errorMonth;

  /// Error message for the year field.
  final String errorYear;

  /// Hint for the month dropdown.
  final String hintMonth;

  /// Hint for the year dropdown.
  final String hintYear;

  /// Hint for the day dropdown.
  final String hintDay;

  /// Hint text style for the dropdown.
  final TextStyle? hintTextStyle;

  /// Enables field validation when used inside a [Form].
  final bool isFormValidator;

  /// Whether each dropdown should expand to fill its available width.
  final bool isExpanded;

  /// Selected day between `1` and `31`.
  final int? selectedDay;

  /// Selected month between `1` and `12`.
  final int? selectedMonth;

  /// Selected year between [startYear] and [endYear].
  final int? selectedYear;

  /// Hides the dropdown underline when `true`.
  final bool isDropdownHideUnderline;

  /// Locale used to resolve month labels.
  final String locale;

  /// Whether to show the year dropdown.
  final bool showYear;

  /// Whether to show the month dropdown.
  final bool showMonth;

  /// Whether to show the day dropdown.
  final bool showDay;

  /// Flex value for the month dropdown.
  final int monthFlex;

  /// Flex value for the day dropdown.
  final int dayFlex;

  /// Flex value for the year dropdown.
  final int yearFlex;

  final OrderFormat _dateFormatOrder;

  /// Order format of the date picker. Defaults to [OrderFormat.mdy].
  OrderFormat get dateFormatOrder => _dateFormatOrder;

  /// Backwards-compatible alias for [dateFormatOrder].
  @Deprecated('Use dateFormatOrder instead.')
  OrderFormat get dateformatorder => _dateFormatOrder;

  const DropdownDatePicker({
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
    OrderFormat dateFormatOrder = OrderFormat.mdy,
    @Deprecated('Use dateFormatOrder instead.') OrderFormat? dateformatorder,
    this.menuHeight,
  })  : _dateFormatOrder = dateformatorder ?? dateFormatOrder,
        assert(width >= 0, 'width must be greater than or equal to 0'),
        assert(
          menuHeight == null || menuHeight > 0,
          'menuHeight must be greater than 0',
        ),
        assert(
          startYear == null || endYear == null || startYear <= endYear,
          'startYear must be less than or equal to endYear',
        ),
        assert(
          selectedDay == null || (selectedDay >= 1 && selectedDay <= 31),
          'selectedDay must be between 1 and 31',
        ),
        assert(
          selectedMonth == null || (selectedMonth >= 1 && selectedMonth <= 12),
          'selectedMonth must be between 1 and 12',
        ),
        assert(
          selectedYear == null ||
              (selectedYear >= (startYear ?? _defaultStartYear) &&
                  (endYear == null || selectedYear <= endYear)),
          'selectedYear must be within the configured year range',
        ),
        assert(
          locale == 'en' ||
              locale == 'gu_IN' ||
              locale == 'te_IN' ||
              locale == 'ta_IN' ||
              locale == 'ml_IN' ||
              locale == 'kn_IN' ||
              locale == 'mr_IN' ||
              locale == 'hi_IN' ||
              locale == 'en_abbv' ||
              locale == 'num' ||
              locale == 'de_DE' ||
              locale == 'zh_CN' ||
              locale == 'it_IT' ||
              locale == 'tr' ||
              locale == 'fr_FR' ||
              locale == 'es_ES' ||
              locale == 'pt_BR' ||
              locale == 'ru_RU' ||
              locale == 'ja' ||
              locale == 'ko_KR' ||
              locale == 'ar' ||
              locale == 'nl_NL' ||
              locale == 'pl_PL' ||
              locale == 'vi' ||
              locale == 'th' ||
              locale == 'sv_SE' ||
              locale == 'el_GR' ||
              locale == 'id_ID',
          'Unsupported locale: $locale',
        ),
        assert(
          showDay || showMonth || showYear,
          'At least one dropdown must be visible',
        ),
        assert(monthFlex > 0, 'monthFlex must be greater than 0'),
        assert(dayFlex > 0, 'dayFlex must be greater than 0'),
        assert(yearFlex > 0, 'yearFlex must be greater than 0'),
        super(key: key);

  @override
  State<DropdownDatePicker> createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  late int _startYear;
  late int _endYear;
  late List<int> _availableDays;
  late List<int> _availableYears;
  late List<Map<String, Object>> _availableMonths;

  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  @override
  void initState() {
    super.initState();
    _syncFromWidget(syncSelectedValues: true);
  }

  @override
  void didUpdateWidget(covariant DropdownDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool selectionChanged = widget.selectedDay != oldWidget.selectedDay ||
        widget.selectedMonth != oldWidget.selectedMonth ||
        widget.selectedYear != oldWidget.selectedYear;
    final bool configChanged = widget.startYear != oldWidget.startYear ||
        widget.endYear != oldWidget.endYear ||
        widget.locale != oldWidget.locale;

    if (selectionChanged || configChanged) {
      _syncFromWidget(syncSelectedValues: selectionChanged);
    }
  }

  void _syncFromWidget({required bool syncSelectedValues}) {
    _startYear = widget.startYear ?? _defaultStartYear;
    _endYear = widget.endYear ?? DateTime.now().year;
    _availableMonths = monthOptionsByLocale[widget.locale] ?? listMonthsEn;
    _availableYears = _buildYearOptions();

    if (syncSelectedValues) {
      _selectedYear = _sanitizeYear(widget.selectedYear);
      _selectedMonth = _sanitizeMonth(widget.selectedMonth);
      _selectedDay = widget.selectedDay;
    } else {
      _selectedYear = _sanitizeYear(_selectedYear);
      _selectedMonth = _sanitizeMonth(_selectedMonth);
    }

    _refreshDayOptions();
  }

  List<int> _buildYearOptions() {
    return List<int>.generate(
      _endYear - _startYear + 1,
      (int index) => _endYear - index,
    );
  }

  void _refreshDayOptions() {
    _availableDays = _buildDayOptions(
      year: _selectedYear,
      month: _selectedMonth,
    );
    _selectedDay = _sanitizeDay(_selectedDay);
  }

  List<int> _buildDayOptions({required int? year, required int? month}) {
    final int dayCount =
        month == null ? 31 : _daysInMonth(year ?? _currentYear, month);
    return List<int>.generate(dayCount, (int index) => index + 1);
  }

  int get _currentYear => DateTime.now().year;

  int? _sanitizeYear(int? value) {
    if (value == null || !_availableYears.contains(value)) {
      return null;
    }

    return value;
  }

  int? _sanitizeMonth(int? value) {
    if (value == null || value < 1 || value > 12) {
      return null;
    }

    return value;
  }

  int? _sanitizeDay(int? value) {
    if (value == null) {
      return null;
    }

    if (_availableDays.contains(value)) {
      return value;
    }

    return _availableDays.isEmpty ? null : _availableDays.last;
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _handleMonthChanged(String? value) {
    final int? previousDay = _selectedDay;

    setState(() {
      _selectedMonth = _parseSelectedValue(value);
      _refreshDayOptions();
    });

    widget.onChangedMonth?.call(_stringValue(_selectedMonth));

    if (_selectedDay != previousDay) {
      widget.onChangedDay?.call(_stringValue(_selectedDay));
    }
  }

  void _handleDayChanged(String? value) {
    setState(() {
      _selectedDay = _sanitizeDay(_parseSelectedValue(value));
    });

    widget.onChangedDay?.call(_stringValue(_selectedDay));
  }

  void _handleYearChanged(String? value) {
    final int? previousDay = _selectedDay;

    setState(() {
      _selectedYear = _sanitizeYear(_parseSelectedValue(value));
      _refreshDayOptions();
    });

    widget.onChangedYear?.call(_stringValue(_selectedYear));

    if (_selectedDay != previousDay) {
      widget.onChangedDay?.call(_stringValue(_selectedDay));
    }
  }

  int? _parseSelectedValue(String? value) {
    return value == null ? null : int.tryParse(value);
  }

  String? _stringValue(int? value) {
    return value?.toString();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> fields = _orderedFields()
        .map(_buildFieldForType)
        .whereType<Widget>()
        .toList(growable: false);

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> children = <Widget>[];
    for (int index = 0; index < fields.length; index++) {
      if (index > 0) {
        children.add(_spacer(widget.width));
      }
      children.add(fields[index]);
    }

    return Row(children: children);
  }

  List<_DateField> _orderedFields() {
    switch (widget.dateFormatOrder) {
      case OrderFormat.dmy:
        return <_DateField>[_DateField.day, _DateField.month, _DateField.year];
      case OrderFormat.mdy:
        return <_DateField>[_DateField.month, _DateField.day, _DateField.year];
      case OrderFormat.ymd:
        return <_DateField>[_DateField.year, _DateField.month, _DateField.day];
      case OrderFormat.ydm:
        return <_DateField>[_DateField.year, _DateField.day, _DateField.month];
      case OrderFormat.myd:
        return <_DateField>[_DateField.month, _DateField.year, _DateField.day];
      case OrderFormat.dym:
        return <_DateField>[_DateField.day, _DateField.year, _DateField.month];
    }
  }

  Widget? _buildFieldForType(_DateField field) {
    switch (field) {
      case _DateField.day:
        return widget.showDay
            ? _buildDropdownContainer(
                flex: widget.dayFlex, child: _buildDayDropdown())
            : null;
      case _DateField.month:
        return widget.showMonth
            ? _buildDropdownContainer(
                flex: widget.monthFlex, child: _buildMonthDropdown())
            : null;
      case _DateField.year:
        return widget.showYear
            ? _buildDropdownContainer(
                flex: widget.yearFlex, child: _buildYearDropdown())
            : null;
    }
  }

  Widget _buildDropdownContainer({
    required int flex,
    required DropdownButtonFormField<String> child,
  }) {
    final Widget dropdown = widget.isDropdownHideUnderline
        ? DropdownButtonHideUnderline(child: child)
        : child;

    return Expanded(
      flex: flex,
      child: DecoratedBox(
        decoration: widget.boxDecoration ?? const BoxDecoration(),
        child: dropdown,
      ),
    );
  }

  DropdownButtonFormField<String> _buildMonthDropdown() {
    return _buildDropdown(
      value: _stringValue(_selectedMonth),
      hintText: widget.hintMonth,
      errorText: widget.errorMonth,
      onChanged: _handleMonthChanged,
      items: _availableMonths.map((Map<String, Object> item) {
        return DropdownMenuItem<String>(
          value: item['id'].toString(),
          child: Text(
            item['value'].toString(),
            style: _dropdownTextStyle,
          ),
        );
      }).toList(growable: false),
    );
  }

  DropdownButtonFormField<String> _buildYearDropdown() {
    return _buildDropdown(
      value: _stringValue(_selectedYear),
      hintText: widget.hintYear,
      errorText: widget.errorYear,
      onChanged: _handleYearChanged,
      items: _availableYears.map((int item) {
        return DropdownMenuItem<String>(
          value: item.toString(),
          child: Text(
            item.toString(),
            style: _dropdownTextStyle,
          ),
        );
      }).toList(growable: false),
    );
  }

  DropdownButtonFormField<String> _buildDayDropdown() {
    return _buildDropdown(
      value: _stringValue(_selectedDay),
      hintText: widget.hintDay,
      errorText: widget.errorDay,
      onChanged: _handleDayChanged,
      items: _availableDays.map((int item) {
        return DropdownMenuItem<String>(
          value: item.toString(),
          child: Text(
            item.toString(),
            style: _dropdownTextStyle,
          ),
        );
      }).toList(growable: false),
    );
  }

  DropdownButtonFormField<String> _buildDropdown({
    required String? value,
    required String hintText,
    required String errorText,
    required ValueChanged<String?> onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return DropdownButtonFormField<String>(
      key: ValueKey<String?>('$hintText-$value'),
      decoration: widget.inputDecoration ??
          (widget.isDropdownHideUnderline ? _underlineFreeDecoration : null),
      hint: Text(hintText, style: widget.hintTextStyle),
      isExpanded: widget.isExpanded,
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      // ignore: deprecated_member_use
      value: value,
      menuMaxHeight: widget.menuHeight,
      onChanged: onChanged,
      validator: (String? selectedValue) {
        return widget.isFormValidator && selectedValue == null
            ? errorText
            : null;
      },
      items: items,
    );
  }

  TextStyle get _dropdownTextStyle {
    return widget.textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        );
  }

  Widget _spacer(double width) {
    return SizedBox(width: width);
  }
}

const InputDecoration _underlineFreeDecoration = InputDecoration(
  border: InputBorder.none,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
  contentPadding: EdgeInsets.zero,
);

enum _DateField {
  day,
  month,
  year,
}
