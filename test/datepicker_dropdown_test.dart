import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';

void main() {
  group('DropdownDatePicker Tests', () {
    testWidgets('DropdownDatePicker widget can be created',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(),
          ),
        ),
      );

      // Verify that the widget is rendered
      expect(find.byType(DropdownDatePicker), findsOneWidget);
    });

    testWidgets('DropdownDatePicker with custom parameters',
        (WidgetTester tester) async {
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

      // Verify that the widget is rendered with custom parameters
      expect(find.byType(DropdownDatePicker), findsOneWidget);
    });

    testWidgets('Selecting a month changes days correctly (leap year)',
        (WidgetTester tester) async {
      String? selectedMonth;
      String? selectedYear;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              startYear: 2000,
              endYear: 2000,
              onChangedMonth: (val) => selectedMonth = val,
              onChangedYear: (val) => selectedYear = val,
            ),
          ),
        ),
      );

      // Select year 2000
      await tester.tap(find.byType(DropdownButtonFormField<String>).at(2),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('2000').last, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(selectedYear, '2000');

      // Select month February
      await tester.tap(find.byType(DropdownButtonFormField<String>).at(0),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.text('February').last, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(selectedMonth, '2');

      // We expect days up to 29. We check the items of the Day Dropdown.
      final DropdownButton<String> dayDropdown =
          tester.widget<DropdownButton<String>>(find.descendant(
              of: find.byType(DropdownButtonFormField<String>).at(1),
              matching: find.byType(DropdownButton<String>)));

      final dayValues = dayDropdown.items?.map((item) => item.value).toList();
      expect(dayValues, contains('29'));
      expect(dayValues, isNot(contains('30')));
    });

    testWidgets('Validating the different OrderFormat options',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              dateformatorder: OrderFormat.dmy,
            ),
          ),
        ),
      );

      // Get the Row widget to verify order
      final row = tester.widget<Row>(find.byType(Row).first);

      // We expect 5 children (day, space, month, space, year) but there is an extra SizedBox
      expect(row.children.length, 6);

      // Day should be first
      expect(
          find.descendant(
              of: find.byWidget(row.children[0]), matching: find.text('Day')),
          findsOneWidget);

      // Month should be third
      expect(
          find.descendant(
              of: find.byWidget(row.children[2]), matching: find.text('Month')),
          findsOneWidget);

      // Year should be fifth
      expect(
          find.descendant(
              of: find.byWidget(row.children[4]), matching: find.text('Year')),
          findsOneWidget);
    });

    testWidgets('Different locales render correct month strings',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DropdownDatePicker(
              locale: 'es_ES',
            ),
          ),
        ),
      );

      await tester.tap(find.byType(DropdownButtonFormField<String>).at(0),
          warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify Spanish month is rendered
      expect(find.text('Enero').last, findsOneWidget);
    });
  });
}
