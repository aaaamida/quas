import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class Calendar extends StatefulWidget {
        const Calendar({super.key, required this.taskDeadline});

        final DateTime taskDeadline;

        @override
        State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

        List<Widget> _managerListContent(BuildContext context) {
                return <Widget>[
                        Theme(
                                data: Theme.of(context).copyWith(
                                        primaryColorDark: Colors.white,
                                        // ignore: prefer_const_constructors
                                        datePickerTheme: DatePickerThemeData(
                                                yearForegroundColor: WidgetStateProperty.fromMap(
                                                        <WidgetStatesConstraint, Color>{
                                                                WidgetState.any: switch (AdaptiveTheme.of(context).mode) {
                                                                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                                                                        _                      => const Color(0xFF000000),
                                                                }
                                                        }
                                                ),
                                                dayForegroundColor: WidgetStateProperty.fromMap(
                                                        <WidgetStatesConstraint, Color>{
                                                                WidgetState.selected: switch (AdaptiveTheme.of(context).mode) {
                                                                        AdaptiveThemeMode.dark => const Color(0xFFFFFFFF),
                                                                        _                      => const Color(0xFF000000),
                                                                },
                                                                WidgetState.any: switch (AdaptiveTheme.of(context).mode) {
                                                                        AdaptiveThemeMode.dark => const Color.fromRGBO(200, 200, 200, 0.75),
                                                                        _                      => Colors.grey,
                                                                },
                                                                WidgetState.disabled: const Color.fromRGBO(0, 0, 0, 1.0)
                                                        }
                                                )
                                        ),
                                ),
                                child: CalendarDatePicker(
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.utc(2170),
                                        onDateChanged: (_) {},
                                ),
                        ),
                        const Divider(thickness: 0.5, indent: 16, endIndent: 16, color: Colors.grey),
                        const SizedBox(height: 4),
                ];
        }

        @override
        Widget build(BuildContext context) {
                return Container(
                        color: switch (AdaptiveTheme.of(context).mode) {
                                AdaptiveThemeMode.dark => const Color(0xFF4A4659),
                                _                      => const Color(0xFFFFFFFF),
                        },
                        child: SingleChildScrollView(
                                child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: _managerListContent(context),
                                ),
                        ),
                );
        }
}
