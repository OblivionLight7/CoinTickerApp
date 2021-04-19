import 'package:flutter/material.dart';

class CardNew extends StatelessWidget {
  const CardNew(
      {Key key,
        @required this.currecyRate,
        @required this.selectedCurrency,
        @required this.currency1});

  final String currecyRate;
  final String selectedCurrency;
  final String currency1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:40.0, horizontal: 58.0),
        child: Text('1 $currency1 = $currecyRate $selectedCurrency', textAlign: TextAlign.center,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      ),
    );
  }
}

