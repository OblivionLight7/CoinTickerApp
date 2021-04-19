import 'dart:convert';
import 'package:http/http.dart' as http;


const apikey = 'E4521D39-222B-4E5E-90B5-299F42EF39D8';
const apiurl = 'https://rest.coinapi.io/v1/exchangerate';

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
  Future getExchangeRate(String currency2) async {
    Map<String, String> criptoPrices = {};
    for (String currency1 in cryptoList) {
      http.Response response =
      await http.get('$apiurl/$currency1/$currency2?apikey=$apikey');
      if (response.statusCode == 200) {
        var decodedBody = jsonDecode(response.body);
        double rate = decodedBody['rate'];
        criptoPrices[currency1] = rate.toStringAsFixed(0);
      } else {
        print('failed ${response.statusCode}');
        return;
      }
    }
    return criptoPrices;
  }
}
