import 'dart:convert';
import 'package:http/http.dart';

class PriceAPICall {
  final String URL = "api.coingecko.com";

  Future<dynamic> getPosts(String vsCurrecncy, String from, String to, String asset) async {
    final params = {
      "vs_currency": vsCurrecncy,
      "from": from,
      "to": to
    };
    print(asset);
    final Map<int, double> priceData = {};
    final uri =
        Uri.https(URL, '/api/v3/coins/'+asset+'/market_chart/range', params);
    final response = await get(uri);
    print(response.statusCode);
    for(var x in jsonDecode(response.body)["prices"]){
      priceData[x[0]] = x[1];
    }
    return priceData;
  }
}
