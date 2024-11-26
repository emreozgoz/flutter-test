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

  final List<String> _categories = [
    'Kira',
    'Elektrik',
    'Su',
    'Doğalgaz',
    'İnternet',
    'Toplu taşıma',
    'Yakıt',
    'Araç bakımı',
    'Otopark',
    'Market alışverişi',
    'Restoran/kafe',
    'Kahve/snack',
    'Kitap',
    'Online eğitimler',
    'Sinema/tiyatro',
    'Spor aktiviteleri',
    'Hobi malzemeleri',
    'Spor salonu üyeliği',
    'Giyim',
    'Kişisel bakım',
    'Kredi kartı borçları',
    'Kredi',
    'Birikim',
    'Hediyeler',
    'Bağışlar',
    'Beklenmeyen masraflar',
    'Yiyecek',
    'Market',
    'Yatırım',
    'Ulaşım',
    'Yakıt',
    'Diğer'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFBBDEFB), // Mavi arka plan
      title: Text(
        'Harcama Ekle',
        style: TextStyle(
            color: Color(0xFF333333), fontWeight: FontWeight.bold), // Gri yazı
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Kategori Seçimi
          DropdownButtonFormField<String>(
            value: _category,
            onChanged: (newCategory) {
              setState(() {
                _category = newCategory!;
              });
            },
            dropdownColor: Color(0xFFBBDEFB), // Açılır menü arka planı (Mavi)
            style: TextStyle(
              color: Color(0xFF333333), // Yazı rengi (Gri)
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFBBDEFB), // Dropdown arka planı
              contentPadding: EdgeInsets.symmetric(
                  vertical: 12.0, horizontal: 15.0), // Padding arttırıldı
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Yuvarlak köşeler
                borderSide: BorderSide(
                    color: Color(0xFF333333), width: 1.5), // Gri çerçeve
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFF333333), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Color(0xFF333333), width: 2.0),
              ),
            ),
            icon: Icon(Icons.arrow_drop_down, color: Color(0xFF333333)),
            items: _categories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Color(0xFF333333), // Yazı rengi
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // Tutar Girişi
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: 'Harcama Tutarı',
              labelStyle: TextStyle(color: Color(0xFF333333)), // Gri yazı
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color(0xFF333333)), // Gri alt çizgi
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color(0xFF333333)), // Gri alt çizgi
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
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFFBBDEFB), // Buton rengi
            padding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 12.0), // Buton boyutu
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Yuvarlak köşeler
            ),
          ),
          child: Text(
            'İptal',
            style: TextStyle(
              color: Color(0xFF333333), // Yazı rengi
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
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
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 14.0, horizontal: 20.0), // Daha geniş tıklama alanı
            backgroundColor:
                Color(0xFF4CAF50), // Canlı yeşil renk (CTA için etkili)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Yuvarlatılmış köşeler
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white), // "Ekle" ikonu
              SizedBox(width: 8.0), // İkon ve metin arasına boşluk
              Text(
                'Ekle',
                style: TextStyle(
                  color: Colors.white, // Beyaz yazı rengi
                  fontWeight: FontWeight.bold, // Vurgulu yazı
                  fontSize: 16.0, // Daha büyük yazı
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
