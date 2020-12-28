import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String routeName;

  const DrawerItem({Key key, this.title, this.iconData, this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushReplacementNamed(context, routeName),
      leading: Icon(iconData),
      title: Text(title),
    );
  }
}
