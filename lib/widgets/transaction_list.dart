import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                key: ValueKey(userTransactions[index].id),
                transaction: userTransactions[index],
                deleteTransaction: deleteTransaction,
              );
            },
            itemCount: userTransactions.length,
          );
          /*ListView(
              children: userTransactions.map((tx) => TransactionItem(
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteTransaction: deleteTransaction,
              )).toList(),
          );
          */
  }
}
