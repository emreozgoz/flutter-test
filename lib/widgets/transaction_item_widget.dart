// lib/widgets/transaction_item_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_test_/widgets/transaction_item.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionItem transaction;

  const TransactionItemWidget({required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Amount'u formatlıyoruz
    String formattedAmount = transaction.amount.toStringAsFixed(2); // İki ondalıklı sayı

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: transaction.color.withOpacity(0.1),
          child: Icon(transaction.icon, color: transaction.color),
        ),
        title: Text(transaction.title),
        // subtitle: Text(dateti('yyyy-MM-dd').format(transaction.date)),
        trailing: Text(
          formattedAmount,  // Formatlanmış tutar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.color,
          ),
        ),
      ),
    );
  }
}
