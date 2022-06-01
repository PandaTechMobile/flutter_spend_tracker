import 'dart:io';
import 'package:flutter/cupertino.dart';
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
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
      id: 't4',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().add(
        Duration(days: -2),
      ),
    ),
    Transaction(
      id: 't5',
      title: 'New Shirt',
      amount: 29.99,
      date: DateTime.now().add(
        Duration(days: -1),
      ),
    ),
    Transaction(
      id: 't6',
      title: 'Coffee',
      amount: 10.99,
      date: DateTime.now().add(
        Duration(hours: -1),
      ),
    ),
    Transaction(
      id: 't7',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().add(
        Duration(days: -2),
      ),
    ),
    Transaction(
      id: 't8',
      title: 'New Shirt',
      amount: 29.99,
      date: DateTime.now().add(
        Duration(days: -1),
      ),
    ),
    Transaction(
      id: 't9',
      title: 'Coffee',
      amount: 10.99,
      date: DateTime.now().add(
        Duration(hours: -1),
      ),
    ),
  ];

  bool _showChart = false;

  @override
  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

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

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,
      ObstructingPreferredSizeWidget appBar, Widget txnListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.75,
              child: Chart(_recentTransactions),
            )
          : txnListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    ObstructingPreferredSizeWidget appBar,
    Widget txnListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(_recentTransactions),
      ),
      txnListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Expense Tracker',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _showAddNewTransaction(context),
                ),
                // IconButton(
                //   onPressed: () => _showAddNewTransaction(context),
                //   icon: Icon(Icons.add),
                // ),
              ],
            ),
          )
        : AppBar(
            title: const Text(
              'Expense Tracker',
            ),
            actions: [
              IconButton(
                onPressed: () => _showAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          )) as ObstructingPreferredSizeWidget;
    ;

    final txnListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.75,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txnListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txnListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddNewTransaction(context),
                  ),
          );
  }
}
