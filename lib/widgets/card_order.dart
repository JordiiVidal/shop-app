import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';

class CardOrder extends StatefulWidget {
  final OrderItem order;
  const CardOrder({Key key, this.order}) : super(key: key);

  @override
  _CardOrderState createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  var isExpanded = false;

  void toggleData() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('${widget.order.totalProducts}'),
            ),
            subtitle: Text('Order created ${widget.order.dateTime.toString()}'),
            title: Text('${widget.order.amount}'),
            trailing: IconButton(
              icon: Icon(isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: toggleData,
            ),
          ),
          if (isExpanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 50, 180),
              child: ListView(
                children: widget.order.products
                    .map((product) => ListTile(
                          title: Text(product.product.title),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
