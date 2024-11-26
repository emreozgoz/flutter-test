import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test_/widgets/expense_dialog.dart';
import 'package:flutter_test_/widgets/line_chart_widget.dart';
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
  List<double> dataList = [10, 20, 30, 40, 50]; // Example data list
  double maxY = 150.0; // Maximum Y value for the chart
  // Harcama ekleme fonksiyonu
  void _addTransaction(TransactionItem transaction) {
    setState(() {
      transactions.add(transaction);
      // Gelir veya gider türüne göre toplamları güncelle
      if (transaction.type) {
        totalExpense += transaction.amount;
      } else {
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
          // Add the AppLineChart widget here
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: AppLineChart(
              dataList: dataList, // Provide the data list
              maxY: maxY, // Provide the max Y value
            ),
          ),
          // Grafik kısmı
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
