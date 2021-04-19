import 'package:flutter/material.dart';
import 'card_new_widget.dart';
import 'constants.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CoinData coinData = CoinData();
  String selectedCurrency = 'USD';
  Map<String, String> ratesMap = {};
  bool isWaiting = true;

  void getRates() async {
    isWaiting = true;
    try {
      var rates = await coinData.getExchangeRate(selectedCurrency);
      setState(() {
        if (rates != null) {
          isWaiting = false;
          ratesMap = rates;
        }
      });
    } catch (e) {
      return;
    }
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in currenciesList) {
      items.add(DropdownMenuItem(child: Text(currency), value: currency));
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: items,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getRates();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getRates();
      },
      children: items,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRates();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/crypto.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text(
              'Coin Ticker🪙',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: buildColumn(),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.blueGrey,
                child: androidDropDown(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildColumn() {
    List<CardNew> cardnewlists = [];
    for (String currency1 in cryptoList) {
      cardnewlists.add(CardNew(
          currecyRate: isWaiting ? '?' : ratesMap[currency1],
          selectedCurrency: selectedCurrency,
          currency1: currency1));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cardnewlists,
    );
  }
}
