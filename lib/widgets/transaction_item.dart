import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  /* Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.green,
      Colors.greenAccent,
      Colors.indigo,
      Colors.indigoAccent,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(5)];
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color.fromARGB(208, 255, 255, 255),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                '₹${widget.transaction.amount}',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuickSand',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 420
            ? TextButton.icon(
                onPressed: (() =>
                    widget.deleteTransaction(widget.transaction.id)),
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Colors.indigo[600]),
                ),
                label: const Text('Delete:'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.indigo[600] /*Theme.of(context).errorColor*/,
                onPressed: () =>
                    widget.deleteTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
