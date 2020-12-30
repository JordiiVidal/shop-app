import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/shopping_cart_page.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var showFavorites = false;
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit)
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showFavorites),
    );
  }
}
