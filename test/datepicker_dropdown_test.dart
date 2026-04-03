import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

void main() {
  group('DropdownDatePicker Tests', () {
    testWidgets('DropdownDatePicker widget can be created', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: DropdownDatePicker())),
      );

      // Verify that the widget is rendered
      expect(find.byType(DropdownDatePicker), findsOneWidget);
    });

    testWidgets('DropdownDatePicker with custom parameters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
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
  });
}
