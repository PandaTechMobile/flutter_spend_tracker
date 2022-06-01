import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function deleteTransaction,
  })  : _transaction = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('\$${_transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(_transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Colors.red,
                onPressed: () => _deleteTransaction(_transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => _deleteTransaction(_transaction.id),
              ),
      ),
    );
  }
}
