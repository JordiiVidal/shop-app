import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/providers/products.dart';

class AdminProductItem extends StatelessWidget {
  final Product product;
  const AdminProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.id + '_admin'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Products>(context, listen: false)
            .deleteProduct(product.id)
            .then(
          (value) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Deleted'),
              ),
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        title: Text(product.title),
        subtitle: Text(
          product.description,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Hero(
          tag: product.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              product.imageUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(
            context,
            EditProductPage.routeName,
            arguments: product.id,
          ),
        ),
      ),
    );
  }
}
