import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/card_order.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    final List<OrderItem> orders = ordersData.orders;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: ordersData.countOrders,
          itemBuilder: (_, i) {
            return CardOrder(order: orders[i]);
          },
        ),
      ),
    );
  }
}
