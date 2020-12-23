import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class Badge extends StatelessWidget {
  const Badge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int total = Provider.of<Cart>(context).countItems;
    return total > 0
        ? Positioned(
            top: 5,
            right: 8,
            child: CircleAvatar(
              maxRadius: 8,
              backgroundColor: Colors.red,
              child: Text(
                '$total',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Container();
  }
}
