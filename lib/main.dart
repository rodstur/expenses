import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';

import 'models/transaction.dart';

void main(List<String> args) => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = TransactionRepository().generate;
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((t) =>
            t.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((el) => el.id == id);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  void onchangeChart() => setState(() {
        _showChart = !_showChart;
      });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final actions = [
      if (_isLandscape)
        IconButton(
            onPressed: onchangeChart,
            icon: Icon(_showChart ? Icons.list : Icons.bar_chart)),
      IconButton(
        onPressed: () => _openTransactionFormModal(context),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    ];
    const titleWidget = Text("Despesas Pessoais");

    final PreferredSizeWidget appBar = AppBar(
      title: titleWidget,
      actions: actions,
    );

    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final page = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showChart || !_isLandscape)
            SizedBox(
              height: avaliableHeight * (_isLandscape ? 0.7 : 0.25),
              child: Chart(_recentTransactions),
            ),
          if (!_showChart || !_isLandscape)
            SizedBox(
              height: avaliableHeight * (_isLandscape ? 1 : 0.75),
              child: TransactionList(_transactions, _removeTransaction),
            ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: page,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
