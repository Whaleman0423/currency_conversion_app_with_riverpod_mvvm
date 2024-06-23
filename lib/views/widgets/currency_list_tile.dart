part of '../../utils/values.dart';

class CurrencyListTile extends StatelessWidget {
  final Currency currency;

  const CurrencyListTile(
    this.currency, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingCachedImage(currency),
      title: currencyTitle(currency),
      trailing: currencyTWDPriceText(currency),
    );
  }
}

Widget leadingCachedImage(Currency currency) {
  return SizedBox(
    height: 40,
    width: 40,
    child: CachedNetworkImage(
      imageUrl: currency.currencyIcon,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        size: 40,
      ),
    ),
  );
}

Widget currencyTWDPriceText(Currency currency) {
  return Text(
    FormatUtils.formatCurrency(currency.twdPrice, 2),
    style: const TextStyle(fontSize: 18),
  );
}

Widget currencyTitle(Currency currency) {
  return Text(
    currency.currency,
    style: const TextStyle(fontSize: 18),
  );
}
