import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  CryptoCard({required this.crypto, required this.rate, required this.fiat});

  final String crypto;
  final String rate;
  final String fiat;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text('1 $crypto = $rate $fiat',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white))));
  }
}
