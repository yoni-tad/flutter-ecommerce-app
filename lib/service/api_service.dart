import 'dart:convert';

import 'package:ecommerce/model/items.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Items>> fetchItems() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/'),
    );

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Items.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch items');
    }
  }
}
