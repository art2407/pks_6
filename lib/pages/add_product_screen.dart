import 'package:flutter/material.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Product) onProductAdded;

  AddProductScreen({required this.onProductAdded});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController(); // Controller for image URL

  String? _imageUrl;

  void _saveProduct() {
    final String name = _nameController.text;
    final String description = _descriptionController.text;
    final double? price = double.tryParse(_priceController.text);
    final String imageUrl = _imageUrlController.text;

    if (name.isNotEmpty && description.isNotEmpty && price != null && imageUrl.isNotEmpty) {
      final newProduct = Product(
        name: name,
        description: description,
        price: price,
        image: imageUrl, // Save the image URL
      );
      widget.onProductAdded(newProduct);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля корректно!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить товар', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Название товара',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Описание товара',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Цена товара',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL изображения',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _imageUrl = value;
                  });
                },
              ),
              SizedBox(height: 20),
              if (_imageUrl != null && _imageUrl!.isNotEmpty)
                Image.network(
                  _imageUrl!,
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Text('Ошибка загрузки изображения');
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Добавить товар', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
