import 'package:flutter/material.dart';
import 'package:coffee_shop/colors.dart';
import 'package:coffee_shop/product_screen.dart';

class FavoriteCoffeeList extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Arabika',
      'image': 'images/arabika.jpg',
      'price': '\$4.35',
    },
    {
      'title': 'Robusta',
      'image': 'images/robusta.jpg',
      'price': '\$4.05',
    },
    {
      'title': 'Espresso',
      'image': 'images/espresso.jpg',
      'price': '\$4.50',
    },
    {
      'title': 'Americano',
      'image': 'images/americano.jpg',
      'price': '\$4.23',
    },
    {
      'title': 'Mocha',
      'image': 'images/mocha.jpg',
      'price': '\$4.5',
    },
    {
      'title': 'Coffee Latte',
      'image': 'images/kopilate.jpg',
      'price': '\$4.4',
    },
    {
      'title': 'Cappucino',
      'image': 'images/cappucino.jpg',
      'price': '\$4.45',
    },
    {
      'title': 'Machiato',
      'image': 'images/machiato.jpg',
      'price': '\$4.25',
    },
    {
      'title': 'Ristretto',
      'image': 'images/ristretto.jpg',
      'price': '\$4.65',
    },
    {
      'title': 'Lungo',
      'image': 'images/lungo.jpg',
      'price': '\$4.75',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try Another Coffee'),
        backgroundColor: colors.grayC1r,
        actions: [],
      ),
      body: ListView(
        children: items.map((item) {
          return Card(
            color: colors.grayC1r,
            elevation: 2, // Kenaikan tingkat kartu (shadow)
            margin: EdgeInsets.all(8), // Ruang antara kartu
            child: ListTile(
              title: Text(item['title']!),
              textColor: Colors.white,
              subtitle: Text(item['price']!),
              leading: Image.asset(
                item['image']!,
                height: 100,
                width: 100,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
