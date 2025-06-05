import 'dart:io';

import 'package:ecommerce/model/items.dart';
import 'package:ecommerce/repository/items_repository.dart';
import 'package:flutter/foundation.dart';

class ItemsProvider with ChangeNotifier {
  final ItemsRepository _repository = ItemsRepository();

  List<Items> _items = [];
  bool _isLoading = false;
  String? _error;

  List<Items> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    try {
      _items = await _repository.getItems();
    } catch (e) {
      print('Error: ${e.toString()}');
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
