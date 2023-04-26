String getFormatedDecimal(double val) {
  return (val % 1 == 0) ? val.toStringAsFixed(0) : val.toStringAsFixed(1);
}
