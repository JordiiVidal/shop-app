import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  const ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final List<Product> products =
        (showFavorites) ? productsData.favorites : productsData.products;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
