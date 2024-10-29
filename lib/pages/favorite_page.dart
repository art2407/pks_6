import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritePage extends StatelessWidget {
  final List<Product> favoriteProducts;

  FavoritePage({required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранные товары', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: favoriteProducts.isEmpty
          ? Center(child: Text('Нет избранных товаров.'))
          : ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(
              '${product.price.toStringAsFixed(2)} ₽',
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
