import 'package:flutter/material.dart';
import 'package:online_shop/models/clothes.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models/cart.dart';

class CartItem extends StatefulWidget {
  Clothes clothes;
  CartItem({super.key, required this.clothes});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // remove item from cart
  void removeItemFromCart() {
    Provider.of<Cart>(context, listen: false).deleteItemFromCart(widget.clothes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.file(File(widget.clothes.imagePaths[0])),
        title: Text(widget.clothes.name),
        subtitle: Text(widget.clothes.price + ' тг'),
        trailing: IconButton(
            icon: Icon(Icons.delete),
          onPressed: removeItemFromCart,
        ),
      ),
    );
  }
}
