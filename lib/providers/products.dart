import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  static const url =
      'https://flutter-shop-app-49175-default-rtdb.firebaseio.com/';

  List<Product> _products = [];

  List<Product> get products => [..._products];

  List<Product> get favorites => _products.where((p) => p.isFavorite).toList();

  Product productById(String id) =>
      _products.firstWhere((element) => element.id == id);

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(url + 'products.json');
      final data = json.decode(response.body);
      if (data != null) {
        final List<Product> loadedProducts = [];
        data.forEach((key, value) {
          final p = Product.fromJson(value, key);
          loadedProducts.add(p);
        });
        _products = loadedProducts;
      }
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addProduct(ProductForm productForm) async {
    try {
      final response = await http.post(url + 'products.json',
          body: productFormToJson(productForm));
      final String id =
          json.decode(response.body)['name']; //{name : id-firebase}
      final Product newProduct = Product.fromProductForm(productForm, id);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> editProduct(String idProduct, ProductForm productForm) async {
    try {
      final Product editedProduct =
          Product.fromProductForm(productForm, idProduct);
      final productIndex =
          _products.indexWhere((element) => element.id == idProduct);
      print(productIndex);
      if (productIndex == null || productIndex < 0) return false;
      _products[productIndex] = editedProduct;
      await http.patch(
        url + 'products/$idProduct.json',
        body: productFormToJson(productForm),
      );
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteProduct(String idProduct) async {
    try {
      final productIndex =
          _products.indexWhere((element) => element.id == idProduct);
      if (productIndex == null || productIndex < 0) return false;
      _products.removeAt(productIndex);
      await http.delete(
        url + 'products/$idProduct.json',
      );

      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
