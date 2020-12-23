import 'package:flutter/material.dart';
import 'package:shop_app/pages/shopping_cart_page.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewPage extends StatefulWidget {
  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var showFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOP APP'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(ShoppingCartPage.routeName),
              ),
             Badge(),
            ],
          ),
          PopupMenuButton(
            onSelected: (val) {
              setState(() {
                showFavorites = (val == FilterOptions.All) ? false : true;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(showFavorites),
    );
  }
}
