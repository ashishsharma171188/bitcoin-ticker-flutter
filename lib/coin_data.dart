import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String apiKey = 'CCBF540C-262A-4D30-8A8F-E29FAFE50A5E';
  Future<String> getCoinData(String assetIdBase, String assetIdQuote) async {
    http.Response f = await http.get(
      Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$assetIdBase/$assetIdQuote?apikey=$apiKey'),
    );
    if (f.statusCode == 200) {
      return jsonDecode(f.body)['rate'].toStringAsFixed(0);
    } else {
      return 'Error Occurred';
    }
  }
}
