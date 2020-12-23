import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/product_overview_page.dart';
import 'package:shop_app/pages/shopping_cart_page.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
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
        },
      ),
    );
  }
}
