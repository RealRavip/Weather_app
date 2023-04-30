import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class reminder_dialog extends StatefulWidget {
  const reminder_dialog({super.key});

  @override
  State<reminder_dialog> createState() => _reminder_dialogState();
}

class _reminder_dialogState extends State<reminder_dialog> {
  List<String> option = ['1', '2'];
  String? selectedOption = '1';
  List<String> time = ['am', 'pm'];
  String? selectedtime = 'am';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Reminders'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('option'),
          DropdownButton(
            value: selectedOption,
            items: option
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 24),
                    )))
                .toList(),
            onChanged: (item) => setState(() {
              selectedOption = item;
            }),
          ),
          Text('Time of the day'),
          DropdownButton(
            value: selectedtime,
            items: time
                .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 24),
                    )))
                .toList(),
            onChanged: (item) => setState(() {
              selectedtime = item;
            }),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text('CANCEL')),
        TextButton(onPressed: () {}, child: Text('ADD')),
      ],
    );
  }
}

Future openDialog(BuildContext context) {
  return showDialog(context: context, builder: (context) => reminder_dialog());
}
