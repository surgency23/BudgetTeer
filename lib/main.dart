import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:budgeteer/entities/transaction.Dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TransactionSubmission(),
    );
  }
}

class TabView extends StatelessWidget {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
          title: Text('BudgetTeer'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.attach_money)),
              Tab(icon: Icon(Icons.settings))
            ],
          ),
        )));
  }
}

class TransactionSubmission extends StatelessWidget {
  final controllerForNumPad = NumpadController(format: NumpadFormat.CURRENCY);
  //Text content = new Text(data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Submit your transaction!"),
        ),
        body: Container(
          //padding: EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(50.0),
                  child: NumpadText(
                      controller: controllerForNumPad,
                      style: TextStyle(fontSize: 50))),
              Expanded(
                  child: Numpad(
                      buttonColor: Colors.blue,
                      controller: controllerForNumPad,
                      buttonTextSize: 35)),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.blue,
                            onPressed: () {
                              String temp = controllerForNumPad.formattedString;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReportsPage(text: (temp))));
                            },
                            child: Text("Reports",
                                style: TextStyle(fontSize: 25)))),
                    SizedBox(
                        width: 250,
                        child: RaisedButton(
                            onPressed: () {
                              String temp = controllerForNumPad.formattedString;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReportsPage(text: (temp))));
                              controllerForNumPad.clear();
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            color: Colors.blue,
                            child:
                                Text("Submit", style: TextStyle(fontSize: 25))))
                  ])
            ],
          ),
        ));
  }
}

class ReportsPage extends StatelessWidget {
  final myController = TextEditingController();
  String text;
  final List<Transaction> _transactions = List<Transaction>();
  ReportsPage({Key key, this.text}) : super(key: key);
  addingToTransactionList(text) {
    Transaction temp;
    temp.total = text;
    _transactions.addAll(temp);
  } //figure out how to pass text to this class, and be able to add it to the total property and push that to the transactions list

  fetchTransactions() {
    var transactions = List<Transaction>();
    String jsonString =
        '[{"total": "20.00"},{"total": "8.00"}, {"total": "20.00"}, {"total": "50.00"}, {"total": "16.00"}, {"total": "6.00"}, {"total": "8.00"}]';
    var transactionsJson = json.decode(jsonString);
    for (var transactionJson in transactionsJson) {
      transactions.add(Transaction.fromJSON(transactionJson));
    }
    _transactions.addAll(transactions);
  }

  @override
  Widget build(BuildContext context) {
    fetchTransactions();
    return Scaffold(
        appBar: AppBar(
          title: Text("Total Transactions Submitted"),
        ),
        body: Stack(children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go Back ' + text),
          ),
          ListView.builder(
            // Build the ListView
            itemBuilder: (context, index) {
              return Card(
                  child: (Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 32, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _transactions[index].total,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text("transaction name"),
                        ],
                      ))));
            },
            itemCount: _transactions.length,
          )
        ]));
  }
}
