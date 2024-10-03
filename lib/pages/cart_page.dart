import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_item.dart';
import '../models/cart.dart';
import '../models/clothes.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              const Text(
                'My Cart🗑',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),

              Expanded(
                  child: ListView.builder(
                    itemCount: value.getUserCart().length,
                      itemBuilder: (context, index) {
                        // get clothes
                        Clothes individualClothes = value.getUserCart()[index];

                        // return the cart item
                        return CartItem(
                          clothes: individualClothes,
                        );
                      }
                  )
              )
            ],
          ),
        )
    );
  }
}
