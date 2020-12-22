import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOP APP'),
      ),
      body: ProductsGrid(),
    );
  }
}
