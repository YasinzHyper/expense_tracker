import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      int totalSum = 0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1), //.substring(0,1)
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get weeklySum {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      //height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        elevation: 4,
        color: Colors.amberAccent,//Theme.of(context).accentColor.withOpacity(0.78),
        child: Container( //or use Padding widget
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((ele) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: ele['day'],
                  dailyAmount: ele['amount'],
                  spentPercentage: weeklySum==0 ? 0 : ((ele['amount'] as int) / weeklySum),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
