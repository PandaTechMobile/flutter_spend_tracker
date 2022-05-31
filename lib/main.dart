import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart_widget.dart';
import './widgets/new_transaction_widget.dart';
import './widgets/transaction_list_widget.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
              //button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

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

  void _addNewTransaction(String title, double amount, DateTime date) {
    var transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((txn) => txn.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text(
        'Expense Tracker',
      ),
      actions: [
        IconButton(
          onPressed: () => _showAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    final txnListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card(
            //   color: Colors.grey,
            //   elevation: 5,
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 200,
            //     child: Text(
            //       'CHART!',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.25,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txnListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.75,
                      child: Chart(_recentTransactions),
                    )
                  : txnListWidget
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
