import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import 'package:shop_app/providers/products.dart';
import 'package:shop_app/pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final snackBar = SnackBar(
      content: Text('Product added to cart'),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () => cart.removeSingleProduct(product.id),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailPage.routeName, arguments: product.id),
        child: GridTile(
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: Consumer<Product>(
              //only reruns this widget
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => product.toggleFavorite(),
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 18,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.addProductCart(1, product);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ),
      ),
    );
  }
}
