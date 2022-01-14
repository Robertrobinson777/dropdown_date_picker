// ignore_for_file: avoid_print

import 'package:datepicker_dropdown/dropdown_datepicker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dropdwon Date Picker'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: DropdownDatePicker(
        isDropdownHideUnderline: true,
        startYear: 2000,
        endYear: 2020,
        width: 10,
        onChangedDay: (value) => print('onChangedDay: $value'),
        onChangedMonth: (value) => print('onChangedMonth: $value'),
        onChangedYear: (value) => print('onChangedYear: $value'),
      )),
    );
  }
}
