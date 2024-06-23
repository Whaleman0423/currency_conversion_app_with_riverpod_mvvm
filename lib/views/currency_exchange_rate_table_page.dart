part of '../utils/values.dart';

class CurrencyExchangeRateTablePage extends StatefulWidget {
  const CurrencyExchangeRateTablePage({super.key});

  @override
  State<CurrencyExchangeRateTablePage> createState() =>
      _CurrencyExchangeRateTablePageState();
}

class _CurrencyExchangeRateTablePageState
    extends State<CurrencyExchangeRateTablePage> {
  late Future<List<Currency>> _currencyFuture;

  @override
  void initState() {
    super.initState();
    _currencyFuture = CurrencyRepository().fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder<List<Currency>>(
        future: _currencyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Currency> currencies = snapshot.data!;

            return mainTableAndButton(currencies);
          }
        },
      ),
    );
  }

  Widget mainTableAndButton(List<Currency> currencies) {
    return RefreshIndicator(
      onRefresh: () async {
        await CurrencyRepository().refreshCurrencies();
        setState(() {
          _currencyFuture = CurrencyRepository().fetchCurrencies();
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: currencyListWidget(currencies),
          ),
          const Divider(height: 16, color: Colors.black),
          rateConversionButton(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text('Rate Table(TWD)',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
      toolbarHeight: 80,
      centerTitle: true,
      bottom: appBarBottomWidget,
    );
  }
}

Widget currencyListWidget(List<Currency> currencies) {
  return ListView.builder(
    itemCount: currencies.length,
    itemBuilder: (context, index) {
      final currency = currencies[index];

      return CurrencyListTile(currency);
    },
  );
}

Widget rateConversionButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
    child: SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          context.push('/conversion');
        },
        child: const Text(
          'Rate Conversion',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget appBarBottomWidget = PreferredSize(
  preferredSize: const Size.fromHeight(10.0),
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 50),
            Expanded(
              flex: 7,
              child: appbarBottomTextWidget("Currency"),
            ),
            Expanded(
              flex: 2,
              child: appbarBottomTextWidget("Price"),
            ),
          ],
        ),
      ),
      const Divider(height: 0, color: Colors.black),
    ],
  ),
);

Text appbarBottomTextWidget(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );
}
