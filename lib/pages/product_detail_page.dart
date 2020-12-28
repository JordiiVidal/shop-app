import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final String idProduct =
        ModalRoute.of(context).settings.arguments as String;
    final Product product =
        Provider.of<Products>(context, listen: false).productById(idProduct);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              width: double.infinity,
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                '${product.price}',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                '${product.description}',
                style: TextStyle(
                  fontSize: 15,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
