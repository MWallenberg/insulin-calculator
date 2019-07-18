class InsulinCalculator {
  final double _gramCarbsPerUnit;
  final double _mmolPerUnit;

  InsulinCalculator(dailyDose) :
    _gramCarbsPerUnit = 500 / dailyDose,
    _mmolPerUnit = 100 / dailyDose;

  double doseForCarbs(int gramCarbs) {
    return gramCarbs / _gramCarbsPerUnit;
  }
}