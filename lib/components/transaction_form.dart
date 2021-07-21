import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) addTransactionFn;

  const TransactionForm(this.addTransactionFn);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final dateController =
      TextEditingController(text: DateFormat("dd/MM/y").format(DateTime.now()));

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0;
    final DateTime? date;

    if (title.isEmpty || value <= 0) return;

    try {
      date = DateFormat("dd/MM/y").parseStrict(dateController.text);
    } catch (e) {
      return;
    }

    widget.addTransactionFn(title, value, date);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), //pode sel até um ano,
      lastDate: DateTime.now(),
    ).then((dateValue) {
      if (dateValue == null) return;

      setState(() {
        dateController.text = DateFormat("dd/MM/y").format(dateValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título",
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Valor (R\$)",
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Data",
                counterText: "",
              ),
              maxLength: 10,
              readOnly: true,
              keyboardType: TextInputType.datetime,
              onSubmitted: (_) => _submitForm(),
              onTap: _showDatePicker,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _submitForm,
                    child: const Text("Nova Transação"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
