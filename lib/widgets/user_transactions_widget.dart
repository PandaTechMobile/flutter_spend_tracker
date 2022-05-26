import 'package:flutter/material.dart';

import './new_transaction_widget.dart';
import './transaction_list_widget.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        TransactionList(_userTransactions),
      ],
    );
  }
}
