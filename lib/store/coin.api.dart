import 'package:http/http.dart' as http;
import 'dart:convert';

class Coin {
  Future loadingCoin(crypto, fiat) async {
    http.Response response = await http.get(
        Uri.parse("https://rest.coinapi.io/v1/exchangerate/$crypto/$fiat"),
        headers: {"X-CoinAPI-Key": "11B9E2CD-5B0E-411C-AEFA-3A7C29DEF3D2"});
    return jsonDecode(response.body);
  }
}
