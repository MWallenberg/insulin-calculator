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
  double _recommendedDose;
  bool _hasCalculated;

  _MealScreenState() {
    _hasCalculated = false;
    SettingsService.getDailyDose().then((val) => setState(() {
      _calculator = InsulinCalculator(val);
    }));
  }

  void _calculate() {
    // TODO: Get the carbs from the form
    int gramCarbs = 45;

    setState(() {
      _recommendedDose = _calculator.doseForCarbs(gramCarbs);
      _hasCalculated = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    suffix: Text('grams'),
                    labelText: 'Carbohydrates in meal' 
                  ),
                  keyboardType: TextInputType.number,
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