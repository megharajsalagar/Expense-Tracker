import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  List<Transaction> _transaction = [];

  TransactionList(this._transaction);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _deleteTransaction(String eId) {
    setState(
        () => widget._transaction.removeWhere((element) => element.eId == eId));
  }

  @override
  Widget build(BuildContext context) {
    return widget._transaction.isEmpty
        ?LayoutBuilder(builder: ((context, constraints) {
          return Column(children: [
            Text(
              "No expenses added yet!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: constraints.maxHeight * 0.6, child: Image.asset('assets/image/waiting.png'))
          ]);
  }))          
     : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FittedBox(
                        child: Text(
                          '${widget._transaction[index].amount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ),
                  title: Text(widget._transaction[index].title,
                      style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(
                      '${DateFormat('dd/MM/yyyy').format(widget._transaction[index].date)}'),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          _deleteTransaction(widget._transaction[index].eId)),
                ),
              );

              //Below code is to build the same view without using builtin widget i.e ListTile
              // return Card(
              //     child: Row(
              //   children: <Widget>[
              //     Container(
              //       child: Text(
              //           '\$' + _transaction[index].amount.toStringAsFixed(2),
              //           style: Theme.of(context).textTheme.titleMedium),
              //       margin: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 15),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.purple, width: 2)),
              //       padding: EdgeInsets.all(10),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           _transaction[index].title,
              //           style: Theme.of(context).textTheme.titleLarge,
              //         ),
              //         Text(DateFormat.yMd().format(_transaction[index].date))
              //       ],
              //     )
              //   ],
              // ));
            },
            itemCount: widget._transaction.length,
          );
  }
}
