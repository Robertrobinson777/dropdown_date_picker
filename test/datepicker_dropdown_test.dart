import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DropdownDatePicker', () {
    testWidgets('widget can be created', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(),
          ),
        ),
      );

      expect(find.byType(DropdownDatePicker), findsOneWidget);
    });

    testWidgets('renders provided initial selections safely', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              startYear: 1990,
              endYear: 2030,
              selectedYear: 2000,
              selectedMonth: 6,
              selectedDay: 15,
            ),
          ),
        ),
      );

      expect(_dropdownValue(tester, dropdownIndex: 0), '6');
      expect(_dropdownValue(tester, dropdownIndex: 1), '15');
      expect(_dropdownValue(tester, dropdownIndex: 2), '2000');
    });

    testWidgets('updates leap-year day options when month changes', (
      WidgetTester tester,
    ) async {
      String? selectedMonth;
      String? selectedYear;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              startYear: 2000,
              endYear: 2000,
              onChangedMonth: (String? value) => selectedMonth = value,
              onChangedYear: (String? value) => selectedYear = value,
            ),
          ),
        ),
      );

      await tester.tap(_dropdownFormFieldFinder(2), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('2000').last, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(selectedYear, '2000');

      await tester.tap(_dropdownFormFieldFinder(0), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('February').last, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(selectedMonth, '2');

      final List<String?> dayValues = _dropdownItems(
        tester,
        dropdownIndex: 1,
      );

      expect(dayValues, contains('29'));
      expect(dayValues, isNot(contains('30')));
    });

    testWidgets('respects the requested field order without trailing spacers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              dateFormatOrder: OrderFormat.dmy,
            ),
          ),
        ),
      );

      final Row row = tester.widget<Row>(find.byType(Row).first);

      expect(row.children.length, 5);
      expect(
        find.descendant(
          of: find.byWidget(row.children[0]),
          matching: find.text('Day'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byWidget(row.children[2]),
          matching: find.text('Month'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byWidget(row.children[4]),
          matching: find.text('Year'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders locale-specific month labels', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              locale: 'es_ES',
            ),
          ),
        ),
      );

      await tester.tap(_dropdownFormFieldFinder(0), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Enero').last, findsOneWidget);
    });

    testWidgets('clamps an impossible initial day to the last valid day', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              selectedDay: 31,
              selectedMonth: 2,
              selectedYear: 2021,
            ),
          ),
        ),
      );

      expect(_dropdownValue(tester, dropdownIndex: 1), '28');
    });

    testWidgets('notifies when month selection reduces the valid day range', (
      WidgetTester tester,
    ) async {
      String? selectedDay;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              selectedDay: 31,
              selectedMonth: 1,
              selectedYear: 2021,
              onChangedDay: (String? value) => selectedDay = value,
            ),
          ),
        ),
      );

      await tester.tap(_dropdownFormFieldFinder(0), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('April').last, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(selectedDay, '30');
      expect(_dropdownValue(tester, dropdownIndex: 1), '30');
    });

    testWidgets('syncs internal state when parent updates selections', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: _ControlledTestHost()));

      expect(_dropdownValue(tester, dropdownIndex: 0), '1');
      expect(_dropdownValue(tester, dropdownIndex: 1), '1');
      expect(_dropdownValue(tester, dropdownIndex: 2), '2020');

      await tester.tap(find.text('Swap'));
      await tester.pumpAndSettle();

      expect(_dropdownValue(tester, dropdownIndex: 0), '12');
      expect(_dropdownValue(tester, dropdownIndex: 1), '24');
      expect(_dropdownValue(tester, dropdownIndex: 2), '2024');
    });
  });
}

Finder _dropdownFormFieldFinder(int index) {
  return find.byType(DropdownButtonFormField<String>).at(index);
}

String? _dropdownValue(WidgetTester tester, {required int dropdownIndex}) {
  return tester
      .widget<DropdownButton<String>>(
        find.descendant(
          of: _dropdownFormFieldFinder(dropdownIndex),
          matching: find.byType(DropdownButton<String>),
        ),
      )
      .value;
}

List<String?> _dropdownItems(WidgetTester tester,
    {required int dropdownIndex}) {
  final DropdownButton<String> dropdown = tester.widget<DropdownButton<String>>(
    find.descendant(
      of: _dropdownFormFieldFinder(dropdownIndex),
      matching: find.byType(DropdownButton<String>),
    ),
  );

  return dropdown.items
          ?.map((DropdownMenuItem<String> item) => item.value)
          .toList(growable: false) ??
      <String?>[];
}

class _ControlledTestHost extends StatefulWidget {
  const _ControlledTestHost();

  @override
  State<_ControlledTestHost> createState() => _ControlledTestHostState();
}

class _ControlledTestHostState extends State<_ControlledTestHost> {
  int _day = 1;
  int _month = 1;
  int _year = 2020;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DropdownDatePicker(
            startYear: 2020,
            endYear: 2024,
            selectedDay: _day,
            selectedMonth: _month,
            selectedYear: _year,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _day = 24;
                _month = 12;
                _year = 2024;
              });
            },
            child: const Text('Swap'),
          ),
        ],
      ),
    );
  }
}
