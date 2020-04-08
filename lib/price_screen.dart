import 'dart:ffi';
import 'dart:ui';
import 'dart:convert';
import 'package:cryptoticker/coin_data.dart';
import 'package:cryptoticker/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  bool isWaiting = false;
  Map<String, String> coinValues = Map();
  double selectedCurrencyPrice = 0.0;
  String selectedCurrency = currenciesList.first;

  void getData() async{
    isWaiting = true;
    try {
      var data = await CoinData().getCoinPriceData(selectedCurrency);
      setState(() {
        coinValues = data;
      });
      print(coinValues);
    } catch (e){
      print(e);
    }
    isWaiting = false;
  }


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
          getData();
          setState(() {

          });
          print(selectedCurrency);
        },
        children: createIosList()
    );
  }

  DropdownButton androidDropDown(){
    return DropdownButton(
        value: selectedCurrency,
        items: createDropDownMenItemList(),
        onChanged: (_value) {
          setState(() {
            selectedCurrency = _value;
            print(selectedCurrency);
            getData();
          });
        });
  }

  List<Widget> createCryptoPadList() {
    List<Widget> list = List();
    for(String crypto in cryptoList) {
      list.add(
          CoinCard(
            price: isWaiting ? "loading..." : coinValues[crypto],
            cryptoCurrency: crypto ,
            selectedCurrency: selectedCurrency,
          )
      );
    }
    return list;
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    print(selectedCurrency);
    getData();
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

class CoinCard extends StatelessWidget {

  final String price;
  final String selectedCurrency;
  final String cryptoCurrency;

  CoinCard({this.price, this.selectedCurrency, this.cryptoCurrency,});

  @override
  Widget build(BuildContext context) {
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
            "1 $cryptoCurrency = $price $selectedCurrency",
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
}
