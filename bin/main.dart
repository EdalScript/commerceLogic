import 'dart:io';
import 'package:test/product.dart';
import 'package:test/cart.dart';


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
      print(cart);
    } else if (line == 'c') {
      if (checkout(cart)) {
        break;
      }
    }
  }
}

Product? chooseProduct() {
  final productsList =
      allProducts.map((product) => product.displayName).join('\n');

  stdout.write('Available products:\n$productsList\nWhat would you like to purchase?: ');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == line) {
      return product;
    }
  }
  print('Not found');
  return null;
}

bool checkout(Cart cart) {
  if (cart.isEmpty) {
    print('Cart is empty');
    return false;
  }
  final total = cart.total();
  print('Total: \€$total');
  stdout.write('Payment in cash: ');
  final line = stdin.readLineSync();
  if (line == null || line.isEmpty) {
    return false;
  }
  final paid = double.tryParse(line);
  if (paid == null) {
    return false;
  }
  if (paid >= total) {
    final change = paid - total;
    print('Change: \€${change.toStringAsFixed(2)}');
    return true;
  } else {
    print('Not enough cash.');
    return false;
  }
}
