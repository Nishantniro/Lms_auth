import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms/core/data/storage/token_service.dart';
import 'package:lms/core/networks/network_const.dart';
import 'package:lms/features/auth/model/token_model.dart';
import 'package:lms/features/auth/pages/login.dart';

import 'package:lms/main.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio dio;
  DioClient() {
    dio = Dio(BaseOptions(baseUrl: kBaseUrl));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) {
            return false;
          }
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio));
  }
}

class AuthInterceptor extends Interceptor {
  Completer<String?>? _completer;
  final Dio dio;
  AuthInterceptor(this.dio);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await TokenService.instance.getAccessToken();
    final isPublicRoute =
        options.path.contains('/auth/login/') ||
        options.path.contains('/auth/sign-up/') ||
        options.path.contains('/auth/verify-email/') ||
        options.path.contains('/auth/token/refresh/');

    if (!isPublicRoute && accessToken != null && accessToken.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (_completer == null) {
        _completer = Completer();
        final refreshToken = await TokenService.instance.getRefreshToken();

        try {
          final response = await dio.post(
            "$kBaseUrl/auth/token/refresh/",
            data: {"refresh": refreshToken},
          );
          final newTokens = TokenModel.fromMap(response.data);

          await TokenService.instance.save(newTokens);
          _completer?.complete(newTokens.access);

          // final requestOptions = err.requestOptions;

          // requestOptions.headers["Authoeization"] = "Bearer $newAccess";

          // final cloneRespose = await dio.fetch(requestOptions);
          // return handler.resolve(cloneRespose);
        } catch (e) {
          _completer?.complete(null);
          // await TokenService.instance.clear();
          // return handler.next(err);
        }
      }
      final accessToken = await _completer?.future;

      if (accessToken != null) {
        try {
          err.requestOptions.headers['Authorization'] = "Bearer $accessToken";
          final response = await DioClient().dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        } finally {
          _completer = null;
        }
      }
      TokenService.instance.clear();
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (_) => false,
      );
      _completer = null;
      return handler.next(err);
    }
    return handler.next(err);
  }
}
