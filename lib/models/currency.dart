part of '../utils/values.dart';

class Currency {
  final String id;
  final String currency;
  final String currencyIcon;
  final double twdPrice;
  final int amountDecimal;

  Currency({
    required this.id,
    required this.currency,
    required this.currencyIcon,
    required this.twdPrice,
    required this.amountDecimal,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      currency: json['currency'],
      currencyIcon: json['currency_icon'],
      twdPrice: json['twd_price'],
      amountDecimal: int.parse(json['amount_decimal']),
    );
  }
}
