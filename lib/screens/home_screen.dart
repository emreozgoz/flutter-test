import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test_/widgets/expense_dialog.dart';
import 'package:flutter_test_/widgets/line_chart_widget.dart';
import 'package:flutter_test_/widgets/transaction_item.dart';
import 'package:flutter_test_/widgets/transaction_item_widget.dart';
import 'details_screen.dart'; // DetailsScreen sayfasını import ettik

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
  List<double> dataList = [
    10,
    20,
    30,
    40,
    50,
    10,
    5,
    3,
    50,
    80,
    10,
    1,
    2,
    3,
    4,
    5,
    6,
    10,
    50,
    60,
    70,
    10
  ]; // Örnek veri listesi
  double maxY = 150.0; // Grafik için maksimum Y değeri

  int _selectedIndex = 0; // Hangi sekmenin seçili olduğunu takip eder
  final PageController _pageController = PageController(); // PageView kontrolörü

  // Harcama ekleme fonksiyonu
  void _addTransaction(TransactionItem transaction) {
    setState(() {
      transactions.add(transaction);
      if (transaction.type) {
        totalExpense += transaction.amount;
      } else {
        totalIncome += transaction.amount;
      }
    });
  }

  // Gelir/Gider seçim ekranını gösterme
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
            _addTransaction(transaction);
          },
        );
      },
    );
  }

  // Sekme değiştirildiğinde
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gelir ve Gider Takibi')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // İlk Sekme: Gelir ve Gider Tablosu
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: AppLineChart(
                  dataList: dataList,
                  maxY: maxY,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Net Gelir',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${totalIncome.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Net Gider',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${totalExpense.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return TransactionItemWidget(transaction: transaction);
                  },
                ),
              ),
            ],
          ),
          // İkinci Sekme: Gider Detayları
          DetailsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Detay',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTransactionTypeSelection(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
