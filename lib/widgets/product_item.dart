import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/pages/product_detail_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ProductDetailPage(product: product)),
        ),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                size: 18,
                color: Theme.of(context).accentColor,
              ),
              onPressed: null,
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
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}
