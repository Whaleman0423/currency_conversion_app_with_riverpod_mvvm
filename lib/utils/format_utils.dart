part of './values.dart';

class FormatUtils {
  static String formatCurrency(double value, int precision) {
    return NumberFormat.currency(symbol: "", decimalDigits: precision)
        .format(value);
  }
}
