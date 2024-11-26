import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detay'),
      ),
      body: Center(
        child: Text('Detaylı Bilgiler'),
      ),
    );
  }
}
