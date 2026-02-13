import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/models/products_model.dart';

class ApiService {
  Future<List<ProductsModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      // FakeStoreAPI doğrudan liste döndüğü için decode edilen veri bir List'tir.
      final List jsonData = jsonDecode(response.body);

      // jsonData zaten bir liste olduğu için doğrudan map edebiliriz.
      return jsonData.map((e) => ProductsModel.fromJson(e)).toList();
    } else {
      throw Exception("Products yüklenemedi");
    }
  }
}
