class Product {
  String name;
  String image;
  String description;
  double price;
  bool isFavorite;
  int quantity;

  Product({required this.name, required this.image, required this.description, required this.price, this.isFavorite = false, this.quantity = 1,});
}