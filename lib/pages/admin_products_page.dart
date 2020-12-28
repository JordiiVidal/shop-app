import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/add_product_page.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/admin_product_item.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class AdminProductsPage extends StatelessWidget {
  static const routeName = '/admin';
  const AdminProductsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final List<Product> products = productsData.products;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Admin Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(
              context,
              AddProductPage.routeName,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => Column(
            children: [
              AdminProductItem(product: products[index]),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
