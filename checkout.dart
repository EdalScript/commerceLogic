import 'dart:io';

class Product {
  const Product({required this.id, required this.name, required this.price});
  final int id;
  final String name;
  final double price;

  String get displayName => '($initial)${name.substring(1)}: \€$price';
  String get initial => name.substring(0, 1);
}

class Item {
  const Item({required this.product, this.quantity = 1});
  final Product product;
  final int quantity;

  double get price => quantity * product.price;

  @override
  String toString() => '$quantity x ${product.name}: \€$price';
}

class Cart {
  final Map<int, Item> _items = {};

  void addProduct(Product product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = Item(product: product, quantity: 1);
    } else {
      _items[product.id] = Item(product: product, quantity: item.quantity + 1);
    }
  }

  double total() => _items.values
      .map((item) => item.price)
      .reduce((value, element) => value + element);

  @override
  String toString() {
    if (_items.isEmpty) {
      return 'Cart is empty!';
    }
    final itemizedList =
        _items.values.map((item) => item.toString()).join('\n');
    return '$itemizedList\nTotal: \${total()}';
  }
}

const allProducts = [
  Product(id: 1, name: 'eggs', price: 1.20),
  Product(id: 2, name: 'milk', price: 1.10),
  Product(id: 3, name: 'onions', price: 1.50),
  Product(id: 4, name: 'bananas', price: 2.00),
  Product(id: 5, name: 'potatoes', price: 2.20),
  Product(id: 6, name: 'rice', price: 2.10),
  Product(id: 7, name: 'fish', price: 5.20),
  Product(id: 8, name: 'coffee', price: 6.25),
  Product(id: 9, name: 'water', price: 0.50),
  Product(id: 10, name: 'bread', price: 0.23),
  Product(id: 11, name: 'apples', price: 2.59),
];

void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
        'What would you like to do? (v)iew items, (a)dd items, (c)heckout: ');
    final line = stdin.readLineSync();
    if (line == 'v') {
      final product = chooseProduct();
      if (product != null) {
        cart.addProduct(product);
        print(cart);
      }
    } else if (line == 'a') {
      //
    } else if (line == 'c') {
      //
    }
  }
}

Product? chooseProduct() {
  final productsList =
      allProducts.map((product) => product.displayName).join('\n');

  stdout.write('Available products:\n$productsList\nYour choice: ');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == line) {
      return product;
    }
  }
  print('Not found');
  return null;
}
