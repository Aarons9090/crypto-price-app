import 'dart:convert';
import 'package:http/http.dart';

class PriceAPICall {
  final String URL = "api.coingecko.com";

  getPosts() async {
    final params = {
      "vs_currency": "eur",
      "from": "1577836800",
      "to": "1609376400"
    };
    final Map<int, double> priceData = {};
    final uri =
        Uri.https(URL, '/api/v3/coins/bitcoin/market_chart/range', params);
    final response = await get(uri);

    for(var x in jsonDecode(response.body)["prices"]){
      priceData[x[0]] = x[1];
    }
    return priceData;
  }
}
