import 'package:dio/dio.dart';
import 'package:e_shop/models/products.dart';

class ProductsService {
  final Dio _dio = Dio();
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        List data = response.data['products'];
        return data.map((e) => ProductModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
