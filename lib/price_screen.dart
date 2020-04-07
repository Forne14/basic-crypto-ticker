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
  var priceBTC = "";
  var priceETH = "";
  var priceLTC = "";
  double selectedCurrencyPrice = 0.0;
  String selectedCurrency = currenciesList.first;

  Future<dynamic> getPriceData(String currency) async {
    var url = "https://api.nomics.com/v1/currencies/ticker?key=5a7ec58775ac8842507c93b12d960906&ids=BTC,ETH,LTC&interval=1d&convert=$currency";
    NetworkHelper networkHelper = NetworkHelper(url);
    var priceData = await networkHelper.getData();
    return priceData;
  }

  void printPriceInformation(String currency) async{
    dynamic priceData = await getPriceData("$currency");
    List<dynamic> body = jsonDecode(priceData.body);
    priceBTC = body[0]["price"];
    priceETH = body[1]["price"];
    priceLTC = body[2]["price"];
    print(priceBTC);
    print(priceETH);
    print(priceLTC);
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
          print(selectedCurrency);
    },
    children: createIosList()
    );
  }

  String getCoinText(String crypto){
    //get coin info
    printPriceInformation(selectedCurrency);
    if(crypto == "BTC"){
      return '1 $crypto = $priceBTC $selectedCurrency';
    }else if (crypto == "ETH"){
      return '1 $crypto = $priceETH $selectedCurrency';
    }else if (crypto == "LTC"){
      return '1 $crypto = $priceLTC $selectedCurrency';
    }
  }



  DropdownButton androidDropDown(){
    return DropdownButton(
            value: selectedCurrency,
            items: createDropDownMenItemList(),
            onChanged: (value) {
              setState(() {
                selectedCurrency = value;
                print(selectedCurrency);
                printPriceInformation(selectedCurrency);
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
            getCoinText(crypto),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    print(selectedCurrency);
    printPriceInformation(selectedCurrency);
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