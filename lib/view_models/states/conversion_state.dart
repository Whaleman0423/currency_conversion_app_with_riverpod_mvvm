part of '../../utils/values.dart';

class ConversionState {
  final Currency? inputCurrency;
  final Currency? outputCurrency;
  final double inputAmount;

  ConversionState({
    this.inputCurrency,
    this.outputCurrency,
    this.inputAmount = 0.0,
  });

  ConversionState copyWith({
    Currency? inputCurrency,
    Currency? outputCurrency,
    double? inputAmount,
  }) {
    return ConversionState(
      inputCurrency: inputCurrency ?? this.inputCurrency,
      outputCurrency: outputCurrency ?? this.outputCurrency,
      inputAmount: inputAmount ?? this.inputAmount,
    );
  }
}
