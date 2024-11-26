import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Map<String, dynamic> expense;

  ExpenseItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense['type']),
      subtitle: Text('${expense['amount']} TL'),
    );
  }
}
