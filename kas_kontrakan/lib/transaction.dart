class Transaction {
  final int id;
  final double amount;
  final String type;
  final String description;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: int.parse(json['id']),
      amount: double.parse(json['amount']),
      type: json['type'],
      description: json['description'],
    );
  }
}
