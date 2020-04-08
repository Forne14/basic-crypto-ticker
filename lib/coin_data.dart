import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network.dart';

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
  'XRP',
  'USDT',
  'XLM',
  'TRX'

];

class CoinData {

  static const apiURL = "https://api.nomics.com/v1/currencies/ticker";
  static const apiKey = "5a7ec58775ac8842507c93b12d960906";

  Future getCoinPriceData(String selectedCurrency) async {
    Map<String, String> coinPrices = Map();
    for(String crypto in cryptoList){
      String url = "$apiURL?key=$apiKey&ids=$crypto&interval=1d&convert=$selectedCurrency";
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        String latestPrice = body[0]["price"];
        coinPrices[crypto] = latestPrice;
      }else{
        print(response.statusCode);
        throw "problem encountered";
      }
    }
    return coinPrices;
  }

}
