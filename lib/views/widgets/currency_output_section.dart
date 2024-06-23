part of '../../utils/values.dart';

class CurrencyOutputSection extends StatelessWidget {
  final Currency? currency;
  final double convertedAmount;
  final VoidCallback onCurrencySelect;

  const CurrencyOutputSection({
    super.key,
    required this.currency,
    required this.convertedAmount,
    required this.onCurrencySelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: onCurrencySelect,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: currency?.currencyIcon ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      currency?.currency ?? 'Select currency',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: TextField(
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              readOnly: true,
              controller: TextEditingController(
                text: convertedAmount
                    .toStringAsFixed(currency?.amountDecimal ?? 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
