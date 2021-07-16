import 'package:expenses/helpers/currency.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

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
              final e = transactions[index];
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
                          "R\$ ${Currency(e.value).shortCurrency}",
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    e.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(DateFormat("dd/MM/y").format(e.date)),
                  trailing: (MediaQuery.of(context).size.width > 480)
                      ? TextButton.icon(
                          onPressed: () => _removeTransaction(e.id),
                          label: const Text("Excluir"),
                          icon: const Icon(Icons.delete),
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).errorColor,
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : IconButton(
                          onPressed: () => _removeTransaction(e.id),
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
          );
  }
}
