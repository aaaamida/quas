import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputForm extends StatefulWidget {
        const InputForm({super.key});
        @override
        State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
        final _formkey = GlobalKey<FormState>();

        @override
        Widget build(BuildContext context) {
                return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                        const Padding(
                                                padding: EdgeInsets.only(bottom: 16),
                                                child: Text("Add a new task", style: TextStyle(color: Color(0xFF5F5286))),
                                        ),
                                        const SizedBox(height: 8),
                                        Form(
                                                key: _formkey,
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
                DateTime? selectedDate;
                return [
                        const SizedBox(height: 24),
                        const Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Title",
                                                border: UnderlineInputBorder(),
                                        ),
                                        enabled: false,
                                )
                        ),
                        const Padding(
                                padding: EdgeInsets.all(8),
                                child: TextField(
                                        decoration: InputDecoration(
                                                hintText: "Category",
                                                border: UnderlineInputBorder(),
                                        ),
                                        enabled: false,
                                )
                        ),
                        FutureBuilder<DateTime?>(
                                future: showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.utc(2099, 12, 31, 23, 59, 59, 00)
                                ),
                                builder: (context, snapshot) {
                                        return Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: TextField(
                                                        decoration: InputDecoration(
                                                                hintText: snapshot.hasData
                                                                        ? DateFormat("yyyy-MM-dd").format(selectedDate!)
                                                                        : "Deadline",
                                                                border: const UnderlineInputBorder(),
                                                        ),
                                                        enabled: false,
                                                ),
                                        );
                                },
                        ),
                ];
        }

        List<Widget> formButtons() {
                return [
                        TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Cancel", style: TextStyle(fontFamily: "Yuruka"))
                        ),
                        const SizedBox(width: 10),
                        // ignore: prefer_const_constructors
                        TextButton(
                                onPressed: null,
                                child: const Text("Add", style: TextStyle(fontFamily: "Yuruka"))
                        ),
                ];
        }


}
