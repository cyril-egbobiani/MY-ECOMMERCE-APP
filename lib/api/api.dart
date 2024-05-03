// import 'dart:io';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio;
  Api(this._dio) {
    initializeDio();
  }

  initializeDio() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(minutes: 8),
      receiveTimeout: const Duration(minutes: 7),
      baseUrl: 'https://fakestoreapi.com/',
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
      },
    );
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: requestInterceptors,
      onError: onErrorInterceptorHandler,
      onResponse: responseInterceptors,
    ));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  requestInterceptors(RequestOptions requestOptions,
      RequestInterceptorHandler requestInterceptorHandler) async {
    requestOptions.headers.addAll({"accept": "application/json"});

    debugPrint('REQUEST URI ==============> ${requestOptions.uri}');
    debugPrint('REQUEST METHODS ==============> ${requestOptions.method}');
    debugPrint('REQUEST HEADERS ==============> ${requestOptions.headers}');
    debugPrint('REQUEST DATA ==============> ${requestOptions.data}');
    return requestInterceptorHandler.next(requestOptions);
  }

  errorInterceptors(
      DioError dioError, ErrorInterceptorHandler errorInterceptorHandler) {
    return errorInterceptorHandler.next(dioError);
  }

  responseInterceptors(Response<dynamic> response,
      ResponseInterceptorHandler responseInterceptorHandler) {
    "======================================================================>";

    debugPrint("RESPONSE DATA ==============>  ${response.data}");
    debugPrint("RESPONSE HEADERS ==============>  ${response.headers}");
    debugPrint("RESPONSE STATUSCODE ==============>  ${response.statusCode}");
    debugPrint(
        "RESPONSE STATUSMESSAGE ==============>  ${response.statusMessage}");
    "======================================================================>";
    return responseInterceptorHandler.next(response);
  }

  apiResponse({dynamic message, dynamic errorCode}) {
    return {
      "message": message ?? "an_error_occurred_please_try_again",
      "errorCode": errorCode ?? "000",
    };
  }

  onErrorInterceptorHandler(DioException e, handler) async {
    if (e.response != null) {
      if (e.response!.statusCode.toString().contains("401")) {
        // if (g.Get.isRegistered<DashboardController>()) {
        //   g.Get.delete<DashboardController>();
        // }
        // g.Get.offAll(() => LoginScreen());
      }
    } else {
      handleError(e);
    }

    return handler.next(e); //continue
  }

  Response? handleError(DioException? e) {
    // debugPrint();
    debugPrint(
        "=============================[ALERT-😱😱😱]: ${e?.requestOptions.uri} ");
    debugPrint(
        "=====================================: [ALERT-😱😱😱] ${e?.error} ");
    debugPrint(
        "=====================================: [ALERT-😱😱😱] ${e?.response?.statusCode}");
    debugPrint(
        "=====================================: [ALERT-😱😱😱] ${e?.response?.data}");

    Response? response;

    switch (e?.type) {
      case DioErrorType.cancel:
        response = Response(
          data: apiResponse(
            message: 'Request cancelled!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioExceptionType.connectionTimeout:
        response = Response(
          data: apiResponse(
            message: "Network connection timed out!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.receiveTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later!",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.sendTimeout:
        response = Response(
          data: apiResponse(
            message: "Something went wrong. Please try again later",
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;

      case DioExceptionType.unknown:
        if (e?.error is SocketException) {
          //g.Get.offAll(() => NoInternetScreen());
          // g.Get.find<GlobalCtr>().showNetworkErrorModal();
        } else if (e?.error is HttpException) {
          response = Response(
            data: apiResponse(
              message: "Network connection issue",
            ),
            requestOptions: RequestOptions(path: ''),
          );
        }
        break;
      default:
        if (e!.response!.data.runtimeType == String &&
            e.error.toString().contains("404")) {
          response = Response(
            data: apiResponse(
              message: "An error occurred, please try again",
              errorCode: '404',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response?.data.runtimeType == String &&
            e.error.toString().contains("400")) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '400',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response?.data.runtimeType == String &&
                e.error.toString().contains("422") ||
            e.response!.statusCode == 422) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '422',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e.response!.statusCode == 401) {
          response = Response(
            data: apiResponse(
              message:
                  e.response?.data ?? "An error occurred, please try again",
              errorCode: '401',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else {
          response = Response(
              data: apiResponse(
                  message: e.response!.data ?? "null",
                  errorCode: e.response!.data["errorCode"] ?? "null"),
              statusCode: e.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        }
    }
    return response;
  }

  Dio get dio => _dio;
}
