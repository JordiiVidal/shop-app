import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/add_product_page.dart';
import 'package:shop_app/pages/admin_products_page.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/product_overview_page.dart';
import 'package:shop_app/pages/shopping_cart_page.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.yellow[300],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ProductOverviewPage(),
          ProductDetailPage.routeName: (_) => ProductDetailPage(),
          ShoppingCartPage.routeName: (_) => ShoppingCartPage(),
          OrdersPage.routeName: (_) => OrdersPage(),
          AdminProductsPage.routeName: (_) => AdminProductsPage(),
          EditProductPage.routeName: (_) => EditProductPage(),
          AddProductPage.routeName: (_) => AddProductPage(),
        },
      ),
    );
  }
}
