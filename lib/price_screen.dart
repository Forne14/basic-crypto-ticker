import 'dart:ui';

import 'package:cryptoticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  double selectedCurrencyPrice = 0.0;
  String selectedCurrency = currenciesList.first;


  DropdownMenuItem<String> createDropDownMenuItem(String s){
    return DropdownMenuItem(child: Text(s), value: s,);
  }

  List<Widget> createIosList(){
    List<Widget> list = List();
    for(String currency in currenciesList){
      list.add(Text(currency, style: TextStyle(color: Colors.white),));
    }
    return list;
  }

  List<DropdownMenuItem> createDropDownMenItemList(){
    List<DropdownMenuItem<String>> list = List();
    for(String currency in currenciesList){
      list.add(createDropDownMenuItem(currency));
    }
    return list;
  }

  CupertinoPicker iosDropDown(){
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
          print(selectedCurrency);
    },
    children: createIosList()
    );
  }

  DropdownButton androidDropDown(){
    return DropdownButton(
            value: selectedCurrency,
            items: createDropDownMenItemList(),
            onChanged: (value) {
              setState(() {
                selectedCurrency = value;
                print(selectedCurrency);
              });
            });
  }

  Padding createCryptoPad(String crypto){
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $selectedCurrencyPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> createCryptoPadList() {
    List<Widget> list = List();
    for(String crypto in cryptoList) {
      list.add(createCryptoPad(crypto));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createCryptoPadList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosDropDown() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

/*

*/