import 'package:flutter/material.dart';
import 'networking.dart';
import 'coin_data.dart';

import 'dart:io' show Platform;

const String apikey='9A08BD14-39E5-4075-A4B4-9AA1A6C39A98';
const String cmn='https://rest.coinapi.io/v1/exchangerate';
var url;
var data1,data2,data3;
var curr='Unit';
var crypto='';

Future<dynamic> getData(String crypto, String val) async {
  curr = val;
  url = '$cmn/$crypto/$val?apikey=$apikey';
  networkhelper nh = networkhelper(url);
  return await nh.getData();
}



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  double rate1=0.0; double rate2=0.0; double rate3=0.0;
  void updateui(int index, dynamic data) {
    setState(() {
      if (data == null || !data.containsKey('rate')) {
        // Fallback to 0.0 if data is invalid or null
        if (index == 0) rate1 = 0.0;
        if (index == 1) rate2 = 0.0;
        if (index == 2) rate3 = 0.0;
      } else {
        // Update rate if data is valid
        if (index == 0) rate1 = data['rate'];
        if (index == 1) rate2 = data['rate'];
        if (index == 2) rate3 = data['rate'];
      }
    });
  }


  String selectedcurrency='USD';
  int len=currenciesList.length;

  List<DropdownMenuItem<String>> currlist=currenciesList.map<DropdownMenuItem<String>>((String curr){
    return DropdownMenuItem<String>(value: curr, child: Text(curr));
  }).toList();

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
                  '1 ${cryptoList[0]} = $rate1 $curr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 ${cryptoList[1]} = $rate2 $curr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 ${cryptoList[2]} = $rate3 $curr',
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
            child: DropdownButton<String>(
                value: selectedcurrency,
                items: currlist,
                onChanged: (String? value){
                  setState(() async{
                    selectedcurrency=value ?? 'USD';
                    data1 = await getData(cryptoList[0], value!);
                    updateui(0,data1);
                    data2 = await getData(cryptoList[1], value);
                    updateui(1,data2);
                    data3 = await getData(cryptoList[2], value);
                    updateui(2,data3);
                  });
            }),
          ),
        ],
      ),
    );
  }
}
