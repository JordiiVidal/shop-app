import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products => [..._products];

  List<Product> get favorites => _products.where((p) => p.isFavorite).toList();

  Product productById(String id) =>
      _products.firstWhere((element) => element.id == id);

  void addProduct(ProductForm productForm) {
    final Product newProduct = Product.fromProductForm(productForm);
    const String url =
        'https://flutter-shop-app-49175-default-rtdb.firebaseio.com/products.json';
    http.post(url, body: newProduct.toJson());
    _products.add(newProduct);
    notifyListeners();
  }

  bool editProduct(String idProduct, ProductForm productForm) {
    final Product editedProduct = Product.fromProductForm(productForm);
    final productIndex =
        _products.indexWhere((element) => element.id == idProduct);
    if (productIndex <= 0 || productIndex == null) return false;
    _products[productIndex] = editedProduct;
    notifyListeners();
    return true;
  }
}
