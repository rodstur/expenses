import 'package:expenses/helpers/currency.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Currency currency;

  final void Function(String p1) _removeTransaction;

  TransactionItem({
    Key? key,
    required this.transaction,
    required void Function(String p1) removeTransaction,
  })  : _removeTransaction = removeTransaction,
        currency = Currency(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: FittedBox(
              child: Text(
                "R\$ ${currency.shortCurrency(value: transaction.value)}",
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat("dd/MM/y").format(transaction.date)),
        trailing: (MediaQuery.of(context).size.width > 480)
            ? TextButton.icon(
                onPressed: () => _removeTransaction(transaction.id),
                label: const Text("Excluir"),
                icon: const Icon(Icons.delete),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                  backgroundColor: Colors.transparent,
                ),
              )
            : IconButton(
                onPressed: () => _removeTransaction(transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
