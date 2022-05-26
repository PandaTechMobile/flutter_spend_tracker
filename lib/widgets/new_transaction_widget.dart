import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              // onChanged: (value) {
              //   newTransactionTitle = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              //onChanged: (value) => newTransactionAmount = value,
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }
}
