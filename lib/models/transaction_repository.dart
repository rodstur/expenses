import 'dart:math';

//import 'package:expenses/helpers/currency.dart';
import 'package:expenses/models/transaction.dart';

class TransactionRepository {
  List<Transaction> get generate => List.generate(5, (index) {
        final str = index.toString() + DateTime.now().microsecond.toString();
        final subt = Random().nextInt(7);

        return Transaction(
          id: index.toString(),
          title: str,
          value: Random().nextInt(200).toDouble(),
          date: DateTime.now().subtract(Duration(days: subt)),
        );
      });

  /*[
        Transaction(
            id: "1",
            title: "Luz",
            value: 100,
            date: DateTime.now().subtract(const Duration(days: 1))),
        Transaction(
            id: "2",
            title: "Agua",
            value: 150,
            date: DateTime.now().subtract(const Duration(days: 2))),
        Transaction(
          id: "3",
          title: "Internet",
          value: 100,
          date: DateTime.now(),
        ),
        Transaction(
            id: "4",
            title: "Alimentacao",
            value: 500,
            date: DateTime.now().subtract(const Duration(days: 2))),
        Transaction(
          id: "5",
          title: "Academia",
          value: 500,
          date: DateTime.now(),
        ),
        Transaction(
          id: "6",
          title: "Remedios",
          value: 50,
          date: DateTime.now(),
        ),
        Transaction(
          id: "7",
          title: "Remedios",
          value: 50,
          date: DateTime.now(),
        ),
        Transaction(
            id: "8",
            title: "Lanches",
            value: 100,
            date: DateTime.now().subtract(const Duration(days: 4))),
        Transaction(
            id: "9",
            title: "Gasolina",
            value: 700,
            date: DateTime.now().subtract(const Duration(days: 6))),
        Transaction(
            id: "10",
            title: "Aluguel",
            value: 1000,
            date: DateTime.now().subtract(const Duration(days: 7))),
        Transaction(
            id: "11",
            title: "Transporte",
            value: 100,
            date: DateTime.now().subtract(const Duration(days: 2))),
      ];*/
}
