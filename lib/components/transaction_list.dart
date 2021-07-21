import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String) _removeTransaction;

  const TransactionList(this.transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Não há transações cadastradas",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transactionEl = transactions[index];
              return TransactionItem(
                  transaction: transactionEl,
                  removeTransaction: _removeTransaction);
            },
          );
  }
}
