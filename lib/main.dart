import 'package:etracker/widget/new_transactions.dart';
import 'package:etracker/widget/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/transactions.dart';
import './widget/chart.dart';

void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build 
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        title: 'eTracker',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                    fontFamily: 'Opensans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                titleMedium: TextStyle(fontFamily: 'Opensans', fontSize: 18),
                titleSmall: const TextStyle(
                    fontFamily: 'Opensans',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          fontFamily: 'Quicksand',
        ),
        home: MyAppHomePage(),
      ),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  @override
  State<MyAppHomePage> createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  final List<Transaction> transaction = [
    // Transaction(
    //   eId: 'e1',
    //   title: 'Shirt',
    //   amount: 90,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   eId: 'e2',
    //   title: 'Pant',
    //   amount: 80,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart =false;

  List<Transaction> get _recentTransactions {
    return transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewValues(String title, double amount, DateTime date) {
    final newTx = Transaction(
        eId: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      transaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: ((_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child:NewTransaction(_addNewValues),
          );
        }));
  }


  @override
  Widget build(BuildContext context) {
    final isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text("eTracker"),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add)),
      ],
    );

    final txListWidget = Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height) *
                    0.6,
                child: TransactionList(transaction));

    final chartWidget =  Container(
              //To show tracker
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              width: double.infinity,
              child: Chart(_recentTransactions),
            );

    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               if(isLandScape) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Text('Show chart'),
                Switch(value: _showChart,onChanged: (value) {
                  setState(() {
                    _showChart = value;
                  });
                },)
                ]   
              ),
        
              if(!isLandScape) chartWidget,
              if(!isLandScape) txListWidget,
        
             if(isLandScape) _showChart ? Container(
              //To show tracker
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              width: double.infinity,
              child: Chart(_recentTransactions),
            )
              : txListWidget,
              //TransactionList(),
            ],
            
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
        );
  }
}
