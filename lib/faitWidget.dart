import 'package:flutter/material.dart';
import 'coin_data.dart' as coins;

class FaitExchangeRateView extends StatelessWidget {
  const FaitExchangeRateView({
    @required this.fiatType,
    @required this.exchangeRate,
    @required this.currencyType,
  });

  final String fiatType;
  final String exchangeRate;
  final String currencyType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $fiatType = $exchangeRate $currencyType',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
