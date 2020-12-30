import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/tools/helpers.dart';

ProductForm productFormFromJson(String str) => ProductForm.fromJson(json.decode(str));

String productFormToJson(ProductForm data) => json.encode(data.toJson());

class ProductForm {
  String title;
  String description;
  double price;
  String imageUrl;

  ProductForm({
    this.title,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory ProductForm.fromJson(Map<String, dynamic> json) => ProductForm(
        price: json["price"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "price": price.toString(),
        "image_url": imageUrl,
      };
}



Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromProductForm(ProductForm form, String id) => Product(
        id: id,
        title: form.title,
        price: form.price,
        imageUrl: form.imageUrl,
        description: form.description,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        isFavorite: json["is_favorite"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price.toString(),
        "image_url": imageUrl,
        "is_favorite": isFavorite ? "1" : "0"
      };

  void toggleFavorite() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }
}
