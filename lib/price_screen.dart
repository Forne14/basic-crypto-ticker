import 'package:cryptoticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  
  DropdownMenuItem<String> createDropDownMenuItem(String s){
    return DropdownMenuItem(child: Text(s), value: s,);
  }

  List<DropdownMenuItem<String>> createDropDownMenItemList(){
    List<DropdownMenuItem<String>> list = List();
    List<String> currencies = currenciesList;
    for(String currency in currencies){
      list.add(createDropDownMenuItem(currency));
    }
    return list;
  }



  String selectedCurrency = "GBP";
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
                  '1 BTC = ? USD',
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
            child: DropdownButton(
              value: selectedCurrency,
                items: createDropDownMenItemList(),
                onChanged: (value) {
                    setState(() {
                      selectedCurrency = value;
                      print(selectedCurrency);
                    });
                  }
                ),
          ),
        ],
      ),
    );
  }
}
