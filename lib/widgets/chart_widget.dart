import 'package:flutter/material.dart';
import 'package:flutter_spend_tracker/widgets/chart_bar_widget.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var amountTotal = 0.0;

      for (var transactionsIndex = 0;
          transactionsIndex < recentTransactions.length;
          transactionsIndex++) {
        if (recentTransactions[transactionsIndex].date.year == weekday.year &&
            recentTransactions[transactionsIndex].date.month == weekday.month &&
            recentTransactions[transactionsIndex].date.day == weekday.day) {
          amountTotal += recentTransactions[transactionsIndex].amount;
        }
      }

      return {'day': DateFormat.E().format(weekday), 'amount': amountTotal};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedTransactionValues.map((data) {
            //return Text('${data['day']}: ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'].toDouble()) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
