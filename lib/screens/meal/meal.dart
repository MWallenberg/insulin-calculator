import 'package:flutter/material.dart';
import 'package:insulin_calc/screens/meal/components/recommendation.dart';
import 'package:insulin_calc/services/insulincalulator.dart';
import 'package:insulin_calc/services/settingsService.dart';


class MealScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MealScreenState();
  }
}

class _MealScreenState extends State<MealScreen> {
  InsulinCalculator _calculator;
  int _gramCarbs;
  double _recommendedDose;
  bool _hasCalculated;
  final _formKey = GlobalKey<FormState>();

  _MealScreenState() {
    _hasCalculated = false;
    SettingsService.getDailyDose().then((val) => setState(() {
      _calculator = InsulinCalculator(val);
    }));
  }

  void _calculate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _recommendedDose = _calculator.doseForCarbs(_gramCarbs);
        _hasCalculated = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    suffix: Text('grams'),
                    labelText: 'Carbohydrates in meal' 
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter the amount of carbohydrates";
                    }
                    return null;
                  },
                  onSaved: (val) => _gramCarbs = int.parse(val),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 1.5,
                  child: RaisedButton(
                    child: Text('Calculate'),
                    onPressed: _calculate,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: _hasCalculated,
            child: DoseRecommendation(
              dose: _recommendedDose,
            ),
          ),
        ],
      ),
    );
  }
}