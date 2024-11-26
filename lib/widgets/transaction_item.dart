import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String category;
  final bool type;
  final String title;
  final String date;
  final double amount; // Amount'u double olarak alıyoruz
  final Color color;

  const TransactionItem({
    required this.icon,
    required this.title,
    required this.category,
    required this.type,
    required this.date,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Amount'u formatlıyoruz
    String formattedAmount = amount.toStringAsFixed(2); // İki ondalıklı sayı

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          formattedAmount,  // Formatlanmış tutar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
