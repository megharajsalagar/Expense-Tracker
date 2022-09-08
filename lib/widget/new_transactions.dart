import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();
  final firstDate = DateTime(DateTime.now().year - 10);
  final lastDate = DateTime.now();
  DateTime? _dateInput;

  void submit() {
    final title = titleInput.text;
    final amount = double.parse(amountInput.text);
    if (title.isEmpty || amount <= 0 || _dateInput == null) return;
    widget.addTx(title, amount, _dateInput);
    Navigator.of(context).pop();
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: firstDate,
            lastDate: lastDate)
        .then(
      (value) => setState(() => _dateInput = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  controller: titleInput,
                  onSubmitted: (_) =>
                      submit), //onChanged: (value) =>titleInput=value ,),
              TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  controller: amountInput,
                  onSubmitted: (_) => submit),
              ListTile(
                title: Text(
                    '${_dateInput == null ? " No Date Chosen!" : 'Date : ${DateFormat('dd/MM/yyyy').format(_dateInput!)}'}'),
                trailing: TextButton(
                  child:
                      Icon(Icons.calendar_month_outlined, color: Colors.blue),
                  onPressed: () => _pickDate(),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: Text('Add Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
