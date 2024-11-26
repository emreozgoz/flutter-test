import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Grafik için fl_chart paketini kullanacağız
import 'package:flutter_test_/widgets/expense_dialog.dart';
import 'package:flutter_test_/widgets/transaction_item.dart';

class DashboardScreen extends StatelessWidget {
  final List<TransactionItem> transactions;  // Harcamalar listesi

  // Parametre olarak transactions'ı alıyoruz
  const DashboardScreen({required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;
    double netBalance = 0.0;

    // Harcamaları ve gelirleri hesapla
    for (var transaction in transactions) {
      if (transaction.category == 'Gelir') {
        totalIncome += transaction.amount as double;
      } else {
        totalExpense += transaction.amount as double;
      }
    }
    netBalance = totalIncome - totalExpense;

    return Scaffold(
      appBar: AppBar(title: Text("Gelir ve Gider Takibi")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Kartlar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard('Toplam Gelir', '₺${totalIncome.toStringAsFixed(2)}', Colors.green),
                _buildCard('Toplam Gider', '₺${totalExpense.toStringAsFixed(2)}', Colors.red),
                _buildCard('Net Bakiye', '₺${netBalance.toStringAsFixed(2)}', Colors.blue),
              ],
            ),
            SizedBox(height: 20),
            // Grafik
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, totalIncome),
                        FlSpot(1, totalExpense),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ExpenseDialog(onSave: (TransactionItem transaction) {
                // Harcama ekleme fonksiyonu
              });
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Kart oluşturma fonksiyonu
  Widget _buildCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
