class Transaction {
  String description;
  DateTime date;
  num amount;
  bool settled;

  Transaction(this.amount, this.date, this.description, this.settled);

  Transaction.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    date = json['date'];
    amount = json['amount'];
    settled = json['settled'];
  }
}
