import 'package:flutter/material.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
// import 'package:budgeteer/entities/transaction.Dart';
// import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static List<Transaction> _key = List<Transaction>();

  @override
  Widget build(BuildContext context) {
    print(_key.toString());
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
                              //String temp = controllerForNumPad.formattedString;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportsPage()));
                            },
                            child: Text("Reports",
                                style: TextStyle(fontSize: 25)))),
                    SizedBox(
                        width: 250,
                        child: RaisedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => ReportsPage()));
                              Transaction temp;
                              temp.total = controllerForNumPad.formattedString;
                              MyApp._key.add(temp);
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
  ReportsPage({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Total Transactions Submitted"),
        ),
        body: Stack(children: <Widget>[
          TransactionListS(
            key: MyApp._key,
          )
          /*ListView.builder(
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
        */
        ]));
  }
}

class Transaction {
  String total;

  Transaction({this.total});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
      };
}

class TransactionListS extends StatefulWidget {
  TransactionListS({Key key}) : super(key: key);

  @override
  TransactionList createState() => TransactionList();
}

class TransactionList extends State<TransactionListS> {
  List<Transaction> transactions = [
    Transaction(total: '20.00'),
    Transaction(total: '8.00'),
    Transaction(total: "50.00")
  ];

  void setTodo(Transaction transaction) {
    transactions.add(transaction);
    throw ("got into settodo");
  }

  @override
  Widget build(BuildContext context) {
    return myListView(context, transactions);
  }
}

Widget myListView(BuildContext context, List<Transaction> transactions) {
  // backing data
  return ListView.builder(
    itemCount: transactions.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(transactions[index].total),
        //leading: Icon(transactions[index].icons),
      );
    },
  );
}
