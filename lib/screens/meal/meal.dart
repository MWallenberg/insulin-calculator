import 'package:flutter/material.dart';
import 'package:insulin_calc/screens/meal/components/recommendation.dart';
import 'package:insulin_calc/services/insulincalulator.dart';
import 'package:insulin_calc/models/preferences.dart';
import 'package:provider/provider.dart';

class MealScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MealScreenState();
  }
}

class _MealScreenState extends State<MealScreen> {
  int _gramCarbs;
  double _recommendedDose;
  bool _hasCalculated;
  final _formKey = GlobalKey<FormState>();

  _MealScreenState() {
    _hasCalculated = false;
    
  }

  void _calculate() {
    final Preferences preferences = Provider.of<Preferences>(context);
    final InsulinCalculator _calculator = InsulinCalculator(preferences.getDailyDose());

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // Set a recommended dose and flag that a calculation has been done.
      // This will reveal the recommendation widget.
      setState(() {
        _recommendedDose = _calculator.doseForCarbs(_gramCarbs);
        _hasCalculated = true;
      });
    } else {
      setState(() {
        _hasCalculated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Wrap(
                  runSpacing: 20.0,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          suffix: Text('grams'),
                          labelText: 'Carbohydrates in meal'),
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
                      alignment: Alignment.center,
                      heightFactor: 1.5,
                      child: RaisedButton(
                        child: Text('Calculate'),
                        onPressed: _calculate,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
