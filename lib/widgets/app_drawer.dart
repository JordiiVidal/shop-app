import 'package:flutter/material.dart';

import 'package:shop_app/widgets/drawer_item.dart';

import 'package:shop_app/pages/admin_products_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_overview_page.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            curve: Curves.bounceInOut,
            child: Container(
              height: 200,
              child: Center(
                child: Text('SHOPPING APP'),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DrawerItem(
                  title: 'Products',
                  iconData: Icons.all_inclusive,
                  routeName: ProductOverviewPage.routeName,
                ),
                DrawerItem(
                  title: 'Orders',
                  iconData: Icons.receipt,
                  routeName: OrdersPage.routeName,
                ),
                DrawerItem(
                  title: 'Admin',
                  iconData: Icons.collections_bookmark,
                  routeName: AdminProductsPage.routeName,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
