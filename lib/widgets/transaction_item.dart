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
  // Kategorilere göre ikonu döndüren bir fonksiyon
  IconData get categoryIcon {
    switch (category) {
      case 'Yiyecek':
        return Icons.fastfood;
      case 'Market':
        return Icons.shopping_cart;
      case 'Yatırım':
        return Icons.align_vertical_bottom;
      case 'Ulaşım':
        return Icons.directions_bus;
      case 'Kira':
        return Icons.home;
      case 'Elektrik':
        return Icons.bolt;
      case 'Su':
        return Icons.water_drop;
      case 'Doğalgaz':
        return Icons.local_fire_department;
      case 'İnternet':
        return Icons.wifi;
      case 'Toplu taşıma':
        return Icons.directions_bus;
      case 'Yakıt':
        return Icons.local_gas_station;
      case 'Araç bakımı':
        return Icons.car_repair;
      case 'Market alışverişi':
        return Icons.shopping_cart;
      case 'Restoran/kafe':
        return Icons.restaurant;
      case 'Kahve/snack':
        return Icons.local_cafe;
      case 'Otopark':
        return Icons.local_parking;
      case 'Kitap':
        return Icons.book_rounded;
      case 'Online eğitimler':
        return Icons.school;
      case 'Sinema/tiyatro':
        return Icons.movie_creation_outlined;
      case 'Spor aktiviteleri':
        return Icons.sports_basketball;
      case 'Hobi malzemeleri':
        return Icons.sports_soccer;
      case 'Spor salonu üyeliği':
        return Icons.fitness_center;
      case 'Giyim':
        return Icons.checkroom;
      case 'Kişisel bakım':
        return Icons.face;
      case 'Kredi kartı borçları':
        return Icons.credit_card;
      case 'Kredi':
        return Icons.account_balance_wallet;
      case 'Hediyeler':
        return Icons.card_giftcard;
      case 'Bağışlar':
        return Icons.favorite;
      case 'Beklenmeyen masraflar':
        return Icons.warning;
      default:
        return Icons.category;
    }
  }

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
          formattedAmount, // Formatlanmış tutar
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
