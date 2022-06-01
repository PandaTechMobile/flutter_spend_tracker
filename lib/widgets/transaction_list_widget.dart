import 'package:flutter/material.dart';
import 'package:flutter_spend_tracker/widgets/transaction_item.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          // NOTE: This key way doesn't work. bug with builder
          // : ListView.builder(
          //     itemCount: _transactions.length,
          //     itemBuilder: (ctx, index) {
          //       return TransactionItem(
          //           key: ValueKey(_transactions[index].id),
          //           transaction: _transactions[index],
          //           deleteTransaction: _deleteTransaction);
          //     },
          //   ),
          : ListView(
              children: _transactions
                  .map((txn) => TransactionItem(
                      key: ValueKey(txn.id),
                      transaction: txn,
                      deleteTransaction: _deleteTransaction))
                  .toList(),
            ),
    );
  }
}

// return Card(
//   child: Row(
//     children: [
//       //Expanded(
//       Container(
//         child: Text(
//           '\$${_transactions[index].amount.toStringAsFixed(2)}',
//           textAlign: TextAlign.start,
//           style: Theme.of(context).textTheme.titleMedium,
//           // style: TextStyle(
//           //   fontWeight: FontWeight.bold,
//           //   fontSize: 18,
//           //   color: Theme.of(context).primaryColor,
//           // ),
//         ),
//         margin: EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 15,
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Theme.of(context).primaryColor,
//             width: 1,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.all(10),
//       ),
//       //),
//       Expanded(
//         child: Column(
//           children: [
//             Text(
//               _transactions[index].title,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               //DateFormat('dd/MM/yyyy').format(txn.date),
//               DateFormat.yMMMd()
//                   .format(_transactions[index].date),
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//       ),
//     ],
//   ),
// );
