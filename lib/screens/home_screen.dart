import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test_/widgets/expense_dialog.dart';
import 'package:flutter_test_/widgets/transaction_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TransactionItem> transactions = [];
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  // Harcama ekleme fonksiyonu
  void _addTransaction(TransactionItem transaction) {
    setState(() {
      transactions.add(transaction);
      // Gelir veya gider türüne göre toplamları güncelle
      if (transaction.type == true) { //True Gelirse bu bir Giderdir
        totalExpense += transaction.amount;
      } else if (transaction.type == false) {
        totalIncome += transaction.amount;
      }
    });
  }

  // BottomSheet ile gelir/gider seçim ekranını gösterme
  void _showTransactionTypeSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Gelir mi Gider mi eklemek istiyorsunuz?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Gelir'),
                onTap: () {
                  Navigator.pop(context);
                  _openExpenseDialog(context, 'Gelir');
                },
              ),
              ListTile(
                title: Text('Gider'),
                onTap: () {
                  Navigator.pop(context);
                  _openExpenseDialog(context, 'Gider');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Harcama ekleme popup'ını açan fonksiyon
  void _openExpenseDialog(BuildContext context, String transactionType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExpenseDialog(
          onSave: (TransactionItem transaction) {
            _addTransaction(transaction); // Harcamayı listeye ekle
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gelir ve Gider Takibi')),
      body: Column(
        children: [
          // Grafik kısmı
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  backgroundColor: Colors.blue.withOpacity(0.2), // Arka plan rengi
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: totalIncome,
                          color: Colors.green,
                          width: 20,
                          borderRadius: BorderRadius.zero,
                        ),
                        BarChartRodData(
                          toY: totalExpense,
                          color: Colors.red,
                          width: 20,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Harcamalar Listesi
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionItem(
                  icon: transaction.icon,
                  category: transaction.category,
                  title: transaction.title,
                  type: transaction.type,
                  date: transaction.date,
                  amount: transaction.amount,
                  color: transaction.color,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionTypeSelection(context); // + butonuna basıldığında seçenekleri göster
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
