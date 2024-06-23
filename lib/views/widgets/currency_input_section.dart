part of '../../utils/values.dart';

class CurrencyInputSection extends StatelessWidget {
  final Currency? currency;
  final double amount;
  final VoidCallback onCurrencySelect;
  final ValueChanged<double> onAmountChange;

  const CurrencyInputSection({
    super.key,
    required this.currency,
    required this.amount,
    required this.onCurrencySelect,
    required this.onAmountChange,
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
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              onChanged: (value) {
                final amount = double.tryParse(value) ?? 0;
                onAmountChange(amount);
              },
            ),
          ),
        ],
      ),
    );
  }
}
