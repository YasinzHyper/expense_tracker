import 'package:expense_tracker/models/transaction.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TotalExpense extends StatelessWidget {
  final int weeklySum;
  final List<Transaction> transactionList;
  TotalExpense({this.weeklySum, this.transactionList});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Container(
    //       padding: EdgeInsets.all(6),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(5),
    //         color: Colors.cyanAccent,
    //         boxShadow: [BoxShadow(blurRadius: 5, blurStyle: BlurStyle.inner)],
    //       ),
    //       child: Text(
    //         'Weekly Total: ₹${weeklySum}',
    //         style: TextStyle(
    //           fontSize: 18,
    //           color: Colors.black,
    //           //backgroundColor: Colors.cyan,
    //         ),
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   ],
    // );
    return Column(
      crossAxisAlignment:
          MediaQuery.of(context).orientation == Orientation.landscape
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.stretch,
      children: [
        if (transactionList.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: null,
              disabledColor: Theme.of(context).primaryColorLight,
              disabledElevation: 2,
              child: Text(
                'Weekly Total: ₹${weeklySum}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  //backgroundColor: Colors.cyan,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
