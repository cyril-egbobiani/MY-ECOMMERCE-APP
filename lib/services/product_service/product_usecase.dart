import 'package:dio/dio.dart';
import 'package:final_tutrorial/services/product_service/product_repo_impl.dart';

class ProductService {
  final ProductRepositoryImplementation impl;
  ProductService(this.impl);

  Future<Response> getAllCategories() async {
    return await impl.getAllCategories();
  }

  Future<Response> getAllProducts() async {
    return await impl.getAllProducts();
  }

  Future<Response> getSingleProducts(String id) async {
    return await impl.getSingleProducts(id);
  }

  Future<Response> getSingleCart(String id) async {
    return await impl.getSingleCart(id);
  }

  Future<Response> addToCart(Map<String, dynamic> data) async {
    return await impl.addToCart(data);
  }
}
