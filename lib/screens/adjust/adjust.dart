import 'package:flutter/material.dart';
import 'package:insulin_calc/screens/adjust/components/adjustmentrecommendation.dart';
import 'package:insulin_calc/services/insulincalulator.dart';
import 'package:insulin_calc/services/settingsService.dart';

class AdjustScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdjustScreenState();
  }
}

class _AdjustScreenState extends State<AdjustScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();
  InsulinCalculator _calculator;

  double _currentMmol;
  double _desiredMmol;
  double _recommendedCarbs;
  double _recommendedDose;
  bool _hasCalculated;

  _AdjustScreenState() {
    _hasCalculated = false;
    SettingsService.getDailyDose().then((val) => setState(() {
          _calculator = InsulinCalculator(val);
        }));

    SettingsService.getTargetBloodSugar().then((val) => setState(() {
          _desiredMmol = val;
          _textFieldController.text = _desiredMmol.toString();
        }));
  }

  _resetState() {
    _hasCalculated = false;
    _recommendedCarbs = null;
    _recommendedDose = null;
  }

  _hideKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  void _calculate() {
    _hideKeyboard();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _resetState();

      // How much does the blood sugar need to change?
      double delta = _desiredMmol - _currentMmol;

      // Set a recommended dose and flag that a calculation has been done.
      // This will reveal the recommendation widget.
      setState(() {
        if (delta == 0) {
          // TODO: Congratulate the user. Well done. Good diabetesing.
        } else if (delta > 0) {
          _recommendedCarbs = _calculator.carbsForIncrease(delta);
        } else {
          _recommendedDose = _calculator.doseForDecrease(-delta);
        }
        _hasCalculated = true;
      });
    } else {
      setState(() {
        _resetState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Wrap(
              runSpacing: 40,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      suffix: Text('mmol/l'),
                      labelText: 'Current blood sugar'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter your current blood sugar level";
                    }
                    return null;
                  },
                  onSaved: (val) => _currentMmol = double.parse(val),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      suffix: Text('mmol/l'),
                      labelText: 'Desired blood sugar'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter your desired blood sugar level";
                    }
                    return null;
                  },
                  onSaved: (val) => _desiredMmol = double.parse(val),
                  controller: _textFieldController,
                ),
                Align(
                  alignment: Alignment.center,
                  heightFactor: 1.5,
                  child: RaisedButton(
                    child: Text('Calculate'),
                    onPressed: _calculate,
                  ),
                ),
                Visibility(
                  visible: _hasCalculated,
                  child: AdjustmentRecommendation(
                    dose: _recommendedDose,
                    gramCarbs: _recommendedCarbs,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
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
