import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  const CartItem({Key key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartProduct.product.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the product from the cart?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('NO'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('SI'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => Provider.of<Cart>(context, listen: false)
          .removeProductCart(cartProduct.product.id),
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text('${cartProduct.quantity}'),
          ),
          title: Text(cartProduct.product.title),
          subtitle: Text('${cartProduct.product.price} €'),
          trailing: Text('${cartProduct.total} €'),
        ),
      ),
    );
  }
}
