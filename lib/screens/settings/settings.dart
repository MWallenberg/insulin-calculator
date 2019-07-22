import 'package:flutter/material.dart';
import 'package:insulin_calc/models/preferences.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsScreen> {
  TextEditingController _textFieldController = TextEditingController();

  _showDialog(
      {@required BuildContext context,
      @required String title,
      @required String suffix,
      @required Function(String) callback,
      String defaultValue}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.number,
              controller: _textFieldController..text = defaultValue ?? "",
              decoration:
                  InputDecoration(suffix: Text(suffix), labelText: title),
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
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Preferences preferences = Provider.of<Preferences>(context);
    int dailyDose = preferences.getDailyDose();
    double targetMmol = preferences.getTargetMmol();

    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text("Daily Insulin Dose"),
          subtitle: Text("$dailyDose units"),
          onTap: () {
            _showDialog(
                title: "Daily Insulin Dose",
                suffix: "units",
                context: context,
                defaultValue: dailyDose?.toString(),
                callback: (String value) {
                  int dose = int.parse(value);
                  preferences.setDailyDose(dose);
                });
          },
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied),
          title: Text("Target Blood Sugar Level"),
          subtitle: Text("$targetMmol mmol/l"),
          onTap: () {
            _showDialog(
                title: "Target Blood Sugar Level",
                suffix: "mmol/l",
                context: context,
                defaultValue: targetMmol?.toString(),
                callback: (String value) {
                  double target = double.parse(value);
                  preferences.setTargetBloodSugar(target);
                });
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
