import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:pks_6/pages/add_product_screen.dart';
import 'package:pks_6/pages/item_page.dart';

class IndexPage extends StatefulWidget {
  final Function(Product) onProductAdded;
  final List<Product> favoriteProducts;
  final Function(Product) onAddToCart;

  IndexPage({
    required this.onProductAdded,
    required this.favoriteProducts,
    required this.onAddToCart,
  });

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<Product> products = [];

  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удалить товар?'),
          content: Text('Вы действительно хотите удалить этот товар?'),
          actions: [
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Удалить'),
              onPressed: () {
                setState(() {
                  products.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
      if (product.isFavorite) {
        if (!widget.favoriteProducts.contains(product)) {
          widget.favoriteProducts.add(product);
        }
      } else {
        widget.favoriteProducts.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин товаров', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: products.isEmpty
          ? Center(child: Text('Товары отсутствуют. Добавьте товар!'))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemPage(
                      product: product,
                      onAddToFavorites: _toggleFavorite,
                      onAddToCart: widget.onAddToCart,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: product.image.startsWith('http')
                            ? Image.network(
                          product.image,
                          fit: BoxFit.cover,
                        )
                            : SizedBox.shrink(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${product.price.toStringAsFixed(2)} ₽',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            _toggleFavorite(product);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_sweep_rounded,
                              color: Colors.red),
                          onPressed: () {
                            _deleteProduct(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart,
                              color: Colors.green),
                          onPressed: () {
                            widget.onAddToCart(product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(onProductAdded: _addProduct),
            ),
          );
        },
        child: Icon(Icons.add_box_outlined, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
