import 'package:flutter/material.dart';

import './widgets/new_transaction_widget.dart';
import './widgets/transaction_list_widget.dart';
import 'models/transaction.dart';

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

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().add(
        Duration(days: -2),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'New Shirt',
      amount: 29.99,
      date: DateTime.now().add(
        Duration(days: -1),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'Coffee',
      amount: 10.99,
      date: DateTime.now().add(
        Duration(hours: -1),
      ),
    ),
  ];

  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewTransaction(String title, double amount) {
    var transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: () => _showAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_userTransactions),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddNewTransaction(context),
      ),
    );
  }
}
