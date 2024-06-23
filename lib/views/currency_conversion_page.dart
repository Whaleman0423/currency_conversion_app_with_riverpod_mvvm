part of '../utils/values.dart';

class CurrencyConversionPage extends ConsumerWidget {
  const CurrencyConversionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: normalAppBar(context, 'Rate Conversion'),
      body: mainConversionCaculator(context, ref),
    );
  }

  Widget mainConversionCaculator(BuildContext context, WidgetRef ref) {
    final conversionState = ref.watch(conversionViewModelProvider);
    final conversionViewModel = ref.read(conversionViewModelProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      margin: const EdgeInsets.all(16.0),
      height: 260,
      decoration: caculatorBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CurrencyInputSection(
              currency: conversionState.inputCurrency,
              amount: conversionState.inputAmount,
              onCurrencySelect: () async {
                final selectedCurrency =
                    await context.push('/currency-selection') as Currency?;
                if (selectedCurrency != null) {
                  conversionViewModel.updateInputCurrency(selectedCurrency);
                }
              },
              onAmountChange: (amount) {
                conversionViewModel.updateInputAmount(amount);
              },
            ),
          ),
          diveiderWithIconAndExchangeRate(conversionState),
          Expanded(
            child: CurrencyOutputSection(
              currency: conversionState.outputCurrency,
              convertedAmount: _calculateConvertedAmount(conversionState),
              onCurrencySelect: () async {
                final selectedCurrency =
                    await context.push('/currency-selection') as Currency?;
                if (selectedCurrency != null) {
                  conversionViewModel.updateOutputCurrency(selectedCurrency);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget diveiderWithIconAndExchangeRate(ConversionState conversionState) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Positioned(
            left: 70,
            child: Container(
              color: Colors.white,
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Icon(Icons.keyboard_double_arrow_down_rounded,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            left: 170,
            bottom: 30,
            child: ConversionRateDisplay(conversionState: conversionState),
          ),
        ],
      ),
    );
  }

  double _calculateConvertedAmount(ConversionState state) {
    if (state.inputCurrency == null || state.outputCurrency == null) {
      return 0;
    }
    return (state.inputAmount * state.inputCurrency!.twdPrice) /
        state.outputCurrency!.twdPrice;
  }
}

class ConversionRateDisplay extends StatelessWidget {
  final ConversionState conversionState;

  const ConversionRateDisplay({super.key, required this.conversionState});

  @override
  Widget build(BuildContext context) {
    if (conversionState.inputCurrency == null ||
        conversionState.outputCurrency == null) {
      return Container();
    }

    final rate = conversionState.inputCurrency!.twdPrice /
        conversionState.outputCurrency!.twdPrice;
    return Text(
        '1 ${conversionState.inputCurrency!.currency} ≈ ${rate.toStringAsFixed(8)} ${conversionState.outputCurrency!.currency}');
  }
}

Decoration caculatorBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: Colors.grey, width: 2),
);
