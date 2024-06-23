part of './values.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CurrencyExchangeRateTablePage(),
    ),
    GoRoute(
      path: '/conversion',
      builder: (context, state) => const CurrencyConversionPage(),
    ),
    GoRoute(
      path: '/currency-selection',
      builder: (context, state) => const CurrencySelectionPage(),
    ),
  ],
);
