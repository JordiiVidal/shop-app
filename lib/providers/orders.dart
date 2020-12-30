import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/tools/helpers.dart';


class OrderItem {
  final String id;
  final double amount;
  final List<CartProduct> products;
  DateTime dateTime;

  OrderItem(
    this.amount,
    this.products,
  )   : this.id = uniqueId,
        this.dateTime = DateTime.now();
  int get totalProducts => this.products.length;
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];
  int get countOrders => _orders.length;

  void addOrder(List<CartProduct> cartProducts, double total) =>
      _orders.add(OrderItem(total, cartProducts));
}
