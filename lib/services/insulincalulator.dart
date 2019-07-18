class InsulinCalculator {
  final double _gramCarbsPerUnit;
  final double _mmolPerUnit;
  final double _mmolPerGramCarbs;

  InsulinCalculator(dailyDose) :
    _gramCarbsPerUnit = 500 / dailyDose,
    _mmolPerUnit = 100 / dailyDose,
    _mmolPerGramCarbs = (100 / dailyDose) / (500 / dailyDose);

  double doseForCarbs(int gramCarbs) {
    return gramCarbs / _gramCarbsPerUnit;
  }

  double doseForDecrease(double mmolDecrease) {
    return mmolDecrease / _mmolPerUnit;
  }

  double carbsForIncrease(double mmolIncrease) {
    return mmolIncrease / _mmolPerGramCarbs;
  }
}