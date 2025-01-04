import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';

class InputForm extends StatefulWidget {
        const InputForm({super.key});
        @override
        State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
        // ignore: unused_field
        late int _day; late int _month; late int _year;
        final _formKey = GlobalKey<FormState>();
        final _titleController = TextEditingController();
        final _categoryController = TextEditingController();

        @override
        Widget build(BuildContext context) {
                return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                        const Padding(
                                                padding: EdgeInsets.only(bottom: 16),
                                                child: Text("Add a new task", style: TextStyle(color: Color(0xFF5F5286))),
                                        ),
                                        const SizedBox(height: 8),
                                        Form(
                                                key: _formKey,
                                                child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: formItems(),
                                                ),
                                        )
                                ],
                        ),
                        actions: formButtons(),
                );
        }

        List<Widget> formItems() {
                return [
                        const SizedBox(height: 24),
                        const Padding(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Title",
                                                border: UnderlineInputBorder(),
                                        ),
                                        enabled: true,
                                )
                        ),
                        const Padding(
                                padding: EdgeInsets.all(4),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Category",
                                                border: UnderlineInputBorder(),
                                        ),
                                        enabled: true,
                                )
                        ),
                        Padding(
                                padding: const EdgeInsets.all(4),
                                child: DropdownDatePicker(
                                        inputDecoration: const InputDecoration(
                                                border: UnderlineInputBorder(),
                                        ),
                                        dateformatorder: OrderFormat.DMY,
                                        startYear: DateTime.now().year,
                                        endYear: DateTime.now().year + 20,
                                        //selectedYear: DateTime.now().year,
                                        //selectedMonth: DateTime.now().month,
                                        width: 15.5,
                                        hintDay: "Day",
                                        hintMonth: "Month",
                                        hintYear: "Year",
                                        onChangedDay: (String? day) => _day = int.parse(day!),
                                        onChangedYear: (String? year) => _year = int.parse(year!),
                                        onChangedMonth: (String? month) => _month = switch (month!) {
                                                "January"   => 1,
                                                "February"  => 2,
                                                "March"     => 3,
                                                "April"     => 4,
                                                "May"       => 5,
                                                "June"      => 6,
                                                "July"      => 7,
                                                "August"    => 8,
                                                "September" => 9,
                                                "October"   => 10,
                                                "November"  => 11,
                                                "December"  => 12,
                                                _           => 0,
                                        },
                                ),
                        ),
                ];
        }

        List<Widget> formButtons() {
                return [
                        TextButton(
                                onPressed: () {
                                        if (mounted) {
                                                Navigator.of(context).pop();
                                        }
                                },
                                child: const Text("Cancel", style: TextStyle(fontFamily: "Nunito"))
                        ),
                        const SizedBox(width: 10),
                        // ignore: prefer_const_constructors
                        TextButton(
                                onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                                final newTask = Task(
                                                        title: _titleController.text,
                                                        category: _categoryController.text,
                                                        deadline: DateTime(_year, _month, _day),
                                                );
                                                Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                                                Navigator.of(context).pop();
                                        }
                                },
                                child: const Text("Add", style: TextStyle(fontFamily: "Nunito"))
                        ),
                ];
        }

        @override
        void dispose() {
                _titleController.dispose();
                _categoryController.dispose();
                super.dispose();
        }
}
