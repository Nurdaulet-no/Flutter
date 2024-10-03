import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'clothes.dart';

class Cart extends ChangeNotifier{
  final Box<Map> _cartBox = Hive.box<Map>('cartBox');
  final Box<Clothes> _clothesBox = Hive.box<Clothes>('clothesBox');
  String userId;
  Cart(this.userId);

  // list of items in user cart
  List<Clothes> get clothesTile => _clothesBox.values.toList();
  List<Clothes> get userCart {
    final userCartMap = _cartBox.get(userId) ?? {};
    return userCartMap.values.map((item) => Clothes.fromJson(item)).toList();
  }

  // get cart
  List<Clothes> getUserCart(){
    return userCart;
  }

  // get clothes tile
  List<Clothes> getClothesTile() {
    return clothesTile;
  }

  // add items to cart
  void addItemToCart(Clothes clothes) {
    final userCartMap = _cartBox.get(userId) ?? {};
    userCartMap[clothes.name] = clothes.toJson();
    _cartBox.put(userId, userCartMap);
    notifyListeners();
  }

  // remove item from cart
  void deleteItemFromCart(Clothes clothes) {
    final userCartMap = _cartBox.get(userId) ?? {};
    userCartMap.remove(clothes.name);
    _cartBox.put(userId, userCartMap);
    notifyListeners();
  }
}