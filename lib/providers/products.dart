import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => [..._products];

  List<Product> get favorites => _products.where((p) => p.isFavorite).toList();

  Product productById(String id) =>
      _products.firstWhere((element) => element.id == id);

  Future<void> addProduct(ProductForm productForm) async {
    const url =
        'https://flutter-shop-app-49175-default-rtdb.firebaseio.com/products.json';
    try {
      final response =
          await http.post(url, body: productFormToJson(productForm));
      final String id =
          json.decode(response.body)['name']; //{name : id-firebase}
      final Product newProduct = Product.fromProductForm(productForm, id);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  bool editProduct(String idProduct, ProductForm productForm) {
    final Product editedProduct =
        Product.fromProductForm(productForm, idProduct);
    final productIndex =
        _products.indexWhere((element) => element.id == idProduct);
    if (productIndex <= 0 || productIndex == null) return false;
    _products[productIndex] = editedProduct;
    notifyListeners();
    return true;
  }
}
