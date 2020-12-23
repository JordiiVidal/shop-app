import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/cart_item.dart';

class ShoppingCartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOPPING CART'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.countItems,
              itemBuilder: (_, index) => CartItem(
                cartProduct: cart.cart.values.toList()[index],
              ),
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 23),
                  ),
                  Chip(
                    label: Text(
                      '${cart.totalAmount} €',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
