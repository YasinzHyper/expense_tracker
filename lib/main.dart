import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:firebase_storage/firebase_storage.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/total_expense.dart';

void main() {
  //  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'ExTrack',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.orange,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            //for all titles
            headline6: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final storage = FirebaseStorage.instance;
  // final storageRef = FirebaseStorage.instance.ref();
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, int txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: txAmount,
      date: selectedDate,
      title: txTitle,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _addTransactionView(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _addTransactionView(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text('Expense Tracker'),
            actions: <Widget>[
              IconButton(
                onPressed: () => _addTransactionView(context),
                icon: Icon(Icons.add),
              ),
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.62,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    print(appBar.preferredSize.height);
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (isLandscape && _showChart)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.64,
                child: Chart(_recentTransactions),
              ),
            Container(
              // height: isLandscape
              //     ? null
              //     : (mediaQuery.size.height -
              //             appBar.preferredSize.height -
              //             mediaQuery.padding.top) *
              //         0.078,
              child: TotalExpense(
                weeklySum: Chart(_recentTransactions).weeklySum.toInt(),
                transactionList: _userTransactions,
              ),
            ),
            if (isLandscape && !_showChart) txListWidget,
            if (!isLandscape) txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container() //if Platform is iOS don't render floatingBtn
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    //backgroundColor: Colors.orangeAccent,
                    onPressed: () => _addTransactionView(context),
                  ),
          );
  }
}
