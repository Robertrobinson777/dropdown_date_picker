// ignore_for_file: avoid_print

import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Datepicker Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(title: 'Dropdwon Date picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  int _selectedDay = 14;
  int _selectedMonth = 10;
  int _selectedYear = 1993;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: _autovalidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownDatePicker(
                locale: "en",
                // inputDecoration: InputDecoration(
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey, width: 1.0),
                //     ),
                //     helperText: '',
                //     contentPadding: const EdgeInsets.all(8),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10))), // optional
                isDropdownHideUnderline: true, // optional
                isFormValidator: true, // optional
                startYear: 1900, // optional
                endYear: 2020, // optional
                width: 10, // optional
                selectedDay: _selectedDay, // optional
                selectedMonth: _selectedMonth, // optional
                selectedYear: _selectedYear, // optional
                onChangedDay: (value) {
                  _selectedDay = int.parse(value!);
                  print('onChangedDay: $value');
                },
                onChangedMonth: (value) {
                  _selectedMonth = int.parse(value!);
                  print('onChangedMonth: $value');
                },
                onChangedYear: (value) {
                  _selectedYear = int.parse(value!);
                  print('onChangedYear: $value');
                },
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
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    DateTime? date =
                        _dateTime(_selectedDay, _selectedMonth, _selectedYear);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                        content: Text('selected date is $date'),
                        elevation: 20,
                      ),
                    );
                  } else {
                    print('on error');
                    setState(() {
                      _autovalidate = AutovalidateMode.always;
                    });
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  //String to datetime conversion
  DateTime? _dateTime(int? day, int? month, int? year) {
    if (day != null && month != null && year != null) {
      return DateTime(year, month, day);
    }
    return null;
  }
}
