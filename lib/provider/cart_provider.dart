import 'dart:convert';

import 'package:ecommerce/model/items.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  double _totalPrice = 0.0;
  List<Items> _cart = [];

  double get totalPrice => _totalPrice;
  List<Items> get cart => _cart;

  Future<void> _saveItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'itemsCart',
      jsonEncode(_cart.map((item) => item.toJson()).toList()),
    );
    prefs.setDouble('itemsPrice', _totalPrice);
  }

  Future<void> getItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('itemsCart');
    _cart =
        cartString != null
            ? List<Items>.from(
              jsonDecode(cartString).map((item) => Items.fromJson(item)),
            )
            : [];
    _totalPrice = prefs.getDouble('itemsPrice') ?? 0;
    notifyListeners();
  }

  Future<void> addItem(Items item) async {
    _cart.add(item);
    _totalPrice += item.price;
    _saveItems();
    notifyListeners();
  }

  Future<void> removeItem(int id) async {
    _cart.removeWhere((item) => item.id == id);
    _totalPrice = cart.fold(0, (sum, item) => sum + item.price);
    _saveItems();
    notifyListeners();
  }

  Future<void> cleanItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
