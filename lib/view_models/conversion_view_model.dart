part of '../utils/values.dart';

class ConversionViewModel extends StateNotifier<ConversionState> {
  ConversionViewModel() : super(ConversionState());

  void updateInputCurrency(Currency currency) {
    state = state.copyWith(inputCurrency: currency);
  }

  void updateOutputCurrency(Currency currency) {
    state = state.copyWith(outputCurrency: currency);
  }

  void updateInputAmount(double amount) {
    state = state.copyWith(inputAmount: amount);
  }
}

final conversionViewModelProvider =
    StateNotifierProvider<ConversionViewModel, ConversionState>(
  (ref) => ConversionViewModel(),
);
