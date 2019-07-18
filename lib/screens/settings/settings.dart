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
  double _targetMmol = 0;
  TextEditingController _textFieldController = TextEditingController();
  
  _SettingsState() {
    SettingsService.getDailyDose().then((val) => setState(() {
      _dailyDose = val;
    }));

    SettingsService.getTargetBloodSugar().then((val) => setState(() {
      _targetMmol = val;
    }));
  }

  _showDialog({
    @required BuildContext context,
    @required String title,
    @required String suffix,
    @required Function(String) callback,
    String defaultValue}
  ) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: _textFieldController..text = defaultValue ?? "",
            decoration: InputDecoration(
              suffix: Text(suffix),
              labelText: title
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("SAVE"),
              onPressed: () {
                callback(_textFieldController.value.text);
                Navigator.of(context).pop();
              }
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
          leading: Icon(Icons.calendar_today),
          title: Text("Daily Insulin Dose"),
          subtitle: Text("$_dailyDose units"),
          onTap: () {
            _showDialog(
              title: "Daily Insulin Dose",
              suffix: "units",
              context: context,
              defaultValue: _dailyDose?.toString(),
              callback: (String value) {
                int dose = int.parse(value);
                SettingsService.setDailyDose(dose).then((success) {
                  setState(() {
                    _dailyDose = dose; 
                  });
                });
              }
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied),
          title: Text("Target Blood Sugar Level"),
          subtitle: Text("$_targetMmol mmol/l"),
          onTap: () {
            _showDialog(
              title: "Target Blood Sugar Level",
              suffix: "mmol/l",
              context: context,
              defaultValue: _targetMmol?.toString(),
              callback: (String value) {
                double target = double.parse(value);
                SettingsService.setTargetBloodSugar(target).then((success) {
                  setState(() {
                    _targetMmol = target; 
                  });
                });
              }
            );
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