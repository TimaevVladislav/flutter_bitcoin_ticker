import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bitcoin_ticker/store/coins.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String fiat = "USD";
  String crypto = "BTC";
  String rate = "";

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(child: Text(currency), value: currency);
      items.add(item);
    }

    return DropdownButton<String>(
        value: fiat,
        items: items,
        onChanged: (value) {
          fiat = value.toString();
        });
  }

  List<Text> pickerDropdown() {
    List<Text> items = [];

    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return items;
  }

  Future loadingCoin() async {
    http.Response response = await http.get(
        Uri.parse("https://rest.coinapi.io/v1/exchangerate/$crypto/$fiat"),
        headers: {"X-CoinAPI-Key": "11B9E2CD-5B0E-411C-AEFA-3A7C29DEF3D2"});
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $crypto = $rate $fiat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                backgroundColor: Colors.lightBlue,
                itemExtent: 32.0,
                onSelectedItemChanged: (index) {
                  setState(() {
                    fiat = currenciesList[index];
                  });
                },
                children: Platform.isIOS ? pickerDropdown() : pickerDropdown(),
              )),
        ],
      ),
    );
  }
}
