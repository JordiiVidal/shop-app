import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';
import 'package:shop_app/providers/product.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String idProduct =
        ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<Products>(context, listen: false).productById(idProduct);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
