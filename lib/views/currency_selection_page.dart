part of '../utils/values.dart';

class CurrencySelectionPage extends StatelessWidget {
  const CurrencySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyRepository = CurrencyRepository();

    return Scaffold(
      appBar: normalAppBar(context, 'Currency Select'),
      body: FutureBuilder<List<Currency>>(
        future: currencyRepository.fetchCurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final currencies = snapshot.data!;

            return ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];

                return ListTile(
                  leading: leadingCachedImage(currency),
                  title: Text(currency.currency),
                  onTap: () {
                    context.pop(currency);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
