import 'package:flutter/material.dart';
import 'transaction_item.dart';

class ExpenseDialog extends StatefulWidget {
  final Function(TransactionItem) onSave;

  ExpenseDialog({required this.onSave});

  @override
  _ExpenseDialogState createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  String _category = 'Yiyecek'; // Varsayılan kategori
  double _amount = 0.0;
  final _amountController = TextEditingController();
  bool _type = true;

  final List<String> _categories = ['Yiyecek', 'Market', 'Yatırım', 'Ulaşım', 'Diğer'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Harcama Ekle'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Kategori Seçimi
          DropdownButton<String>(
            value: _category,
            onChanged: (newCategory) {
              setState(() {
                _category = newCategory!;
              });
            },
            items: _categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Tutar Girişi
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Harcama Tutarı'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                // Girilen değeri double olarak al ve hata olursa 0.0 yap
                _amount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ],
      ),
      actions: [
        // İptal Butonu
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Popup'ı kapat
          },
          child: Text('İptal'),
        ),
        // Ekle Butonu
        TextButton(
          onPressed: () {
            // Eğer tutar 0 veya boşsa ekleme yapılmasın
            if (_amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Geçerli bir tutar girin')),
              );
              return;
            }

            final transaction = TransactionItem(
              icon: Icons.money,  // Harcama için bir ikon
              title: '$_category Harcaması',  // Kategoriyi başlık olarak kullan
              category: _category,  // Kategori
              type: _type,
              date: DateTime.now().toString(),  // Geçerli tarih
              amount: _amount,  // Tutar, iki ondalıklı
              color: Colors.blue,  // Renk
            );

            widget.onSave(transaction); // Harcamayı kaydet
            Navigator.pop(context); // Popup'ı kapat
          },
          child: Text('Ekle'),
        ),
      ],
    );
  }
}
