import 'package:flutter/material.dart';

import './widgets/user_transactions_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // String? newTransactionTitle;
  // String? newTransactionAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.grey,
            elevation: 5,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                'CHART!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          UserTransactions(),
          // Container(
          //   height: 200,
          //   child: Card(
          //     color: Colors.grey,
          //     child: Text(
          //       'List of Txn!',
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
