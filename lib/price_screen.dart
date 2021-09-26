import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcoin_ticker/coin_data.dart' as coins;
import 'dart:io' show Platform;
import 'faitWidget.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String ddlSelectValue = 'USD',
      fiatType = 'BTC',
      exchangeRateBTC = '',
      exchangeRateETH = '',
      exchangeRateLTC = '';
  int cupertinoPickerCurrentIndex = 0;
  bool isWaiting = true;
  coins.CoinData coinData = coins.CoinData();

  @override
  void initState() {
    super.initState();
    getExchangeRate(ddlSelectValue);
  }

  void getExchangeRate(String ddlSelectValue) async {
    try {
      for (String faitType in coins.cryptoList) {
        String rate = await coinData.getCoinData(faitType, ddlSelectValue);
        setState(() {
          switch (faitType) {
            case 'BTC':
              exchangeRateBTC = rate;
              break;
            case 'ETH':
              exchangeRateETH = rate;
              break;
            case 'LTC':
              exchangeRateLTC = rate;
              break;
          }
        });
      }
      setState(() {
        isWaiting = false;
      });
    } catch (ex) {
      throw 'Some Exception occurred in getExchangeRate Method. Follow is the error: ' +
          ex.toString();
    }
  }

  CupertinoPicker iOSPicker() {
    List<Text> textItems = [];
    for (String currency in coins.currenciesList) {
      textItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      useMagnifier: true,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          exchangeRateBTC = exchangeRateETH = exchangeRateLTC = '';
          cupertinoPickerCurrentIndex = index;
          ddlSelectValue = coins.currenciesList[index];
          isWaiting = true;
          getExchangeRate(ddlSelectValue);
        });
      },
      children: textItems,
    );
  }

  DropdownButton androidDropDownButton() {
    List<DropdownMenuItem<String>> ddlMenuItems = [];
    for (String currency in coins.currenciesList) {
      ddlMenuItems.add(
        DropdownMenuItem(
          value: currency,
          child: Text(currency),
        ),
      );
    }
    return DropdownButton(
      value: ddlSelectValue,
      onChanged: (value) {
        setState(() {
          exchangeRateBTC = exchangeRateETH = exchangeRateLTC = '?';
          ddlSelectValue = value;
          isWaiting = true;
          getExchangeRate(ddlSelectValue);
        });
      },
      //Used to fetch dropdown values of currencies.
      items: ddlMenuItems,
    );
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                FaitExchangeRateView(
                    fiatType: coins.cryptoList[0],
                    exchangeRate: isWaiting ? '?' : exchangeRateBTC,
                    currencyType: ddlSelectValue),
                SizedBox(
                  width: 20,
                ),
                FaitExchangeRateView(
                    fiatType: coins.cryptoList[1],
                    exchangeRate: isWaiting ? '?' : exchangeRateETH,
                    currencyType: ddlSelectValue),
                SizedBox(
                  width: 20,
                ),
                FaitExchangeRateView(
                    fiatType: coins.cryptoList[2],
                    exchangeRate: isWaiting ? '?' : exchangeRateLTC,
                    currencyType: ddlSelectValue),
              ],
            ),
          ),
          Container(
            height: 80.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
