import 'package:flutter/material.dart';
import 'package:insulin_calc/services/settingsService.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsScreen> {
  int _dailyDose = 0;
  TextEditingController _textFieldController = TextEditingController();
  
  _SettingsState() {
    SettingsService.getDailyDose().then((val) => setState(() {
      _dailyDose = val;
    }));
  }

  _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Daily Insulin Dose"),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: _textFieldController..text = _dailyDose.toString(),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                int dose = int.parse(_textFieldController.value.text);
                SettingsService.setDailyDose(dose).then((success) {
                  Navigator.of(context).pop();
                  setState(() {
                    _dailyDose = dose; 
                  });
                });
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Daily Insulin Dose"),
          subtitle: Text("$_dailyDose units"),
          onTap: () {
            _showDialog(context);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textFieldController.dispose();
    super.dispose();
  }
}