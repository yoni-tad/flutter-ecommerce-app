import 'dart:io';

import 'package:ecommerce/model/items.dart';
import 'package:ecommerce/repository/items_repository.dart';
import 'package:flutter/foundation.dart';

class ItemsProvider with ChangeNotifier {
  final ItemsRepository _repository = ItemsRepository();

  List<Items> _items = [];
  List<Items> _allItems = [];
  bool _isLoading = false;
  String? _error;

  List<Items> get items => _items;
  List<Items> get allItems => _allItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    try {
      _items = await _repository.getItems();
      _allItems = await _repository.getItems();
    } catch (e) {
      print('Error: ${e.toString()}');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> search(String value) async {
    _items =
        _allItems
            .where(
              (item) => item.title.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  Future<void> categoryFilter(String category) async {
    _items = _items.where((item) => item.category == category).toList();
    notifyListeners();
  }

  Future<void> ratingFilter(int rate) async {
    _items = _items.where((item) => item.rating.rate >= rate).toList();
    notifyListeners();
  }

  Future<void> priceFilter(int start, int end) async {
    _items = _items.where((item) => item.price.toInt() >= start && item.price.toInt() <= end).toList();
    notifyListeners();
  }

  Future<void> clearSearch() async {
    _items = _allItems;
    notifyListeners();
  }
}
