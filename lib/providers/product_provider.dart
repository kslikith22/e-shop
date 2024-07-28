import 'package:e_shop/models/products.dart';
import 'package:e_shop/services/products_services.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  bool isLoading = false;
  final _productsService = ProductsService();

  Future getAllProducts() async {
    isLoading = true;
    notifyListeners();
    _products = await _productsService.getAllProducts();
    isLoading = false;
    notifyListeners();
  }
}
