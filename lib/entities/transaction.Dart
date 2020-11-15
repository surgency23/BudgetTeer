import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
