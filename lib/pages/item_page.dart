import 'package:flutter/material.dart';
import '../models/product.dart';

class ItemPage extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToFavorites;
  final Function(Product) onAddToCart;

  const ItemPage({
    super.key,
    required this.product,
    required this.onAddToFavorites,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () => onAddToFavorites(product),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            onPressed: () => onAddToCart(product),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Отображение изображения товара по URL
              Image.network(
                product.image,
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Ошибка загрузки изображения',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Название товара
              Text(
                product.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Цена товара
              Text(
                '${product.price.toStringAsFixed(2)} ₽',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              // Описание товара
              Text(
                product.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
