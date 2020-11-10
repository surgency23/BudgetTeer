class Transaction {
  String total;

  Transaction({this.total});

  Transaction.fromJSON(Map<String, dynamic> json) {
    total = json["total"];
  }
}
