import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum APIMethod { post, get, put, delete }

class APIService {
  APIService._singleton();

  static final APIService instance = APIService._singleton();

  static APIService get singleton => instance;

  late Dio _dio;

  String get baseUrl {
    return "baseURl";
  }

  void configureDio({
    required String baseURL,
    required bool isAfterLogin,
    required String bearerToken,
    Map<String, dynamic>? defaultHeaders,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    void Function(RequestOptions options, RequestInterceptorHandler handler)?
    onRequest,
    void Function(Response response, ResponseInterceptorHandler handler)?
    onResponse,
    void Function(DioException exception, ErrorInterceptorHandler handler)?
    onError,
  }) {
    if (isAfterLogin) {
      defaultHeaders ??= {};
      defaultHeaders.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': bearerToken,
      });
    } else {
      defaultHeaders ??= {};
      defaultHeaders.addAll({
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
    }
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout: connectionTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers:
            defaultHeaders,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            onRequest ??
            (options, handler) {
              print('Request: ${options.method}  ${options.path}');
              print('Headers: ${options.headers}');
              print('Query Params: ${options.queryParameters}');
              handler.next(options);
            },
        onResponse:
            onResponse ??
            (response, handler) {
              print('Response: ${response.statusCode} ${response.data}');
              handler.next(response);
            },
        onError:
            onError ??
            (DioException e, handler) {
              debugPrint('Error: ${e.message}');
              handler.next(e);
            },
      ),
    );
  }

  //Get response method use this function
  Future<Response> getRequest(
    String endPoint, {
    Map<String, dynamic>? queryParameter,
  }) async {
    try {
      Response response = await _dio.get(
        endPoint,
        queryParameters: queryParameter,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //Post response method use this function
  Future<Response> postRequest(
    String endPoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      debugPrint('end point ::: $endPoint');
      debugPrint('data ::: $data');
      Response response = await _dio.post(endPoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
