import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartProducts;

  CartPage({required this.cartProducts});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _incrementQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void _decrementQuantity(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: widget.cartProducts.isEmpty
          ? Center(child: Text('Корзина пуста.'))
          : ListView.builder(
        itemCount: widget.cartProducts.length,
        itemBuilder: (context, index) {
          final product = widget.cartProducts[index];

          return Dismissible(
            key: Key(index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Удалить товар из корзины?'),
                    content: Text('Вы уверены, что хотите удалить ${product.name}?'),
                    actions: [
                      TextButton(
                        child: Text('Отмена'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Удалить'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) {
              setState(() {
                product.quantity = 1;
                widget.cartProducts.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} удален из корзины')),
              );
            },
            child: ListTile(
              leading: Icon(Icons.shopping_bag_sharp, size: 40, color: Colors.blue[900]),
              title: Text(product.name),
              subtitle: Text(
                '${(product.price * product.quantity).toStringAsFixed(2)} ₽',
                style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.blueAccent),
                    onPressed: () => _decrementQuantity(product),
                  ),
                  Text(
                    '${product.quantity}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.blueAccent),
                    onPressed: () => _incrementQuantity(product),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
