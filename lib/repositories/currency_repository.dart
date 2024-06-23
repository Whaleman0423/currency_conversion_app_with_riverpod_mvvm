part of '../utils/values.dart';

class CurrencyRepository {
  final http.Client client;
  static const String apiUrl = CURRENCY_API_URL;

  CurrencyRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Currency>> fetchCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedCurrencies');

    if (cachedData != null) {
      // 如果本地有缓存，解析並返回
      List<dynamic> jsonResponse = json.decode(cachedData);

      return jsonResponse
          .map((currency) => Currency.fromJson(currency))
          .toList();
    } else {
      final response = await client.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        await prefs.setString('cachedCurrencies', response.body);

        return jsonResponse
            .map((currency) => Currency.fromJson(currency))
            .toList();
      } else {
        throw Exception('Failed to load currencies');
      }
    }
  }

  Future<void> refreshCurrencies() async {
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cachedCurrencies', response.body);
    } else {
      throw Exception('Failed to refresh currencies');
    }
  }
}
