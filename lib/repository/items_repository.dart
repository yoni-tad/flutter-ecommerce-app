import 'package:ecommerce/model/items.dart';
import 'package:ecommerce/service/api_service.dart';

class ItemsRepository {
  final ApiService _apiService = ApiService();

  Future<List<Items>> getItems() {
    return _apiService.fetchItems();
  } 

}