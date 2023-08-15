import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bitcoin_ticker/store/coin.api.dart';
import 'package:flutter_bitcoin_ticker/components/card.dart';
import 'package:flutter_bitcoin_ticker/store/coins.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String fiat = "USD";
  String crypto = "BTC";
  bool loading = false;
  Map<String, dynamic> rates = {"BTC": "", "ETH": "", "LTC": ""};

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

  @override
  void initState() {
    super.initState();
    loadingCoinRates();
  }

  void loadingCoinRates() {
    for (String c in cryptoList) {
      setCoinRate(c);
    }
  }

  setCoinRate(c) async {
    var response = await Coin().loadingCoin(c, fiat);

    if (response["rate"] == null) {
      loading = true;
    }

    setState(() {
      rates[c] = response["rate"].toString();
      crypto = response["asset_id_base"];
      fiat = response["asset_id_quote"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(child: Text('Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(children: <Widget>[
              CryptoCard(
                  crypto: "BTC",
                  rate: loading ? "?" : rates["BTC"],
                  fiat: fiat),
              CryptoCard(
                  crypto: "ETH",
                  rate: loading ? "?" : rates["ETH"],
                  fiat: fiat),
              CryptoCard(
                  crypto: "LTC", rate: loading ? "?" : rates["LTC"], fiat: fiat)
            ]),
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
                    loadingCoinRates();
                  });
                },
                children: Platform.isIOS ? pickerDropdown() : pickerDropdown(),
              )),
        ],
      ),
    );
  }
}
