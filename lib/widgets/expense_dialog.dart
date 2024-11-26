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
      backgroundColor: Color(0xFFBBDEFB), // Mavi arka plan
      title: Text(
        'Harcama Ekle',
        style: TextStyle(color: Color(0xFF333333), fontWeight: FontWeight.bold), // Gri yazı
      ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Text(
          value,
          style: TextStyle(
            color: Color(0xFF333333), // Daha soft gri yazı rengi
            fontSize: 16.0, // Yazı boyutunu hafif büyütün
          ),
        ),
      ),
    );
  }).toList(),
  dropdownColor: Color(0xFFE3F2FD), // Daha açık pastel mavi
  icon: Icon(Icons.arrow_drop_down, color: Color(0xFF333333)), // Soft ok ikonu
  style: TextStyle(
    color: Color(0xFF333333), // Ana metin rengi
    fontSize: 16.0,
  ),
  underline: Container(
    height: 2,
    color: Color(0xFFBBDEFB), // Soft mavi alt çizgi
  ),
  borderRadius: BorderRadius.circular(10), // Yuvarlatılmış kenarlar
);

          // Tutar Girişi
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Harcama Tutarı',
              labelStyle: TextStyle(color: Color(0xFF333333)), // Gri yazı
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF333333)), // Gri alt çizgi
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF333333)), // Gri alt çizgi
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(color: Color(0xFF333333)), // Gri yazı
            onChanged: (value) {
              setState(() {
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
            Navigator.pop(context);
          },
          child: Text(
            'İptal',
            style: TextStyle(color: Color(0xFF333333)), // Gri yazı
          ),
        ),
        // Ekle Butonu
        TextButton(
          onPressed: () {
            if (_amount <= 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Geçerli bir tutar girin')),
              );
              return;
            }

            final transaction = TransactionItem(
              icon: Icons.money, // Harcama için bir ikon
              title: '$_category Harcaması', // Kategoriyi başlık olarak kullan
              category: _category, // Kategori
              type: _type,
              date: DateTime.now().toString(), // Geçerli tarih
              amount: _amount, // Tutar
              color: Color(0xFF333333), // Çizgi rengi ile uyumlu gri renk
            );

            widget.onSave(transaction);
            Navigator.pop(context);
          },
          child: Text(
            'Ekle',
            style: TextStyle(color: Color(0xFF333333)), // Gri yazı
          ),
        ),
      ],
    );
  }
}
