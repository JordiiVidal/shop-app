import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/tools/helpers.dart';


class CartProduct {
  String id;
  final Product product;
  int quantity;
  double total;

  CartProduct(
    this.product,
    this.quantity,
  )   : this.id = uniqueId,
        this.total = product.price * quantity;

  void addQuantity() {
    this.quantity += 1;
    this.calculateTotal();
  }

  void lessQuantity() {
    if (quantity > 0) {
      this.quantity -= 1;
      this.calculateTotal();
    }
  }

  void calculateTotal() => this.total = this.quantity * this.product.price;
}

class Cart with ChangeNotifier {
  Map<String, CartProduct> _cart = {};

  Map<String, CartProduct> get cart => {..._cart};
  int get countItems => _cart == null ? 0 : _cart.length;
  double get totalAmount {
    var total = 0.0;
    _cart.forEach((key, value) {
      total += value.total;
    });
    return total;
  }

  void addProductCart(int quantity, Product product) {
    if (_cart.containsKey(product.id)) {
      // _cart.update(product.id, (existingCartProduct) => CartProduct(product, quantity));
      _cart[product.id].addQuantity();
    } else {
      _cart.putIfAbsent(product.id, () => CartProduct(product, quantity));
    }
    notifyListeners();
  }

  void removeProductCart(String id) {
    _cart.remove(id);
    notifyListeners();
  }

  void removeSingleProduct(String id) {
    if (!_cart.containsKey(id)) return;

    print(_cart[id].quantity);
    if (_cart[id].quantity > 1) {
      _cart[id].lessQuantity();
    } else {
      _cart.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _cart = {};
    notifyListeners();
  }
}
