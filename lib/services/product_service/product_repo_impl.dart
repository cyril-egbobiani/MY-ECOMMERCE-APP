// import 'dart:convert';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_tutrorial/api/api.dart';
import 'package:final_tutrorial/services/product_service/product_repository.dart';

class ProductRepositoryImplementation extends ProductRepository {
  final Api _api = Api(Dio());

  @override
  getAllCategories() async {
    try {
      return await _api.dio.get('/products/categories');
    } on DioException catch (e) {
      return _api.handleError(e);
    }
  }

  @override
  getAllProducts() async {
    try {
      return await _api.dio.get('/products');
    } on DioException catch (e) {
      return _api.handleError(e);
    }
  }

  @override
  getSingleProducts(String id) async {
    try {
      return await _api.dio
          .get('/products/$id', data: jsonEncode({'data': id}));
    } on DioException catch (e) {
      return _api.handleError(e);
    }
  }

  @override
  getSingleCart(String userId) async {
    try {
      return await _api.dio.get('/carts/$userId');
    } on DioException catch (e) {
      return _api.handleError(e);
    }
  }

  @override
  addToCart(Map<String, dynamic> data) async {
    try {
      return await _api.dio.post('/carts', data: data);
    } on DioException catch (e) {
      return _api.handleError(e);
    }
  }
}
