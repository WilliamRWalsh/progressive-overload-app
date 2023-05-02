String? getFormatedDecimal(double? val) {
  if (val == null) {
    return null;
  }
  return (val % 1 == 0) ? val.toStringAsFixed(0) : val.toStringAsFixed(1);
}
