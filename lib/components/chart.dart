import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/currency.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  const Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      double sum = 0;

      for (final t in transactions) {
        if (DateFormat.yMd().format(day) == DateFormat.yMd().format(t.date)) {
          sum += t.value;
        }
      }

      return {
        "day": DateFormat.E().format(day),
        "value": sum,
      };
    }).reversed.toList();
  }

  double get _weekSumTransactions {
    return groupedTransactions
        .map((e) => e["value"]! as double)
        .reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: groupedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                value: Currency(e["value"]! as double).shortCurrency,
                percentage: _weekSumTransactions == 0
                    ? 0
                    : (e["value"]! as double) / _weekSumTransactions,
                label: e["day"].toString(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
