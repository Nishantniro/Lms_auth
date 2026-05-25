import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lms/core/data/storage/token_service.dart';
import 'package:lms/features/auth/model/token_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio dio;
  DioClient() {
    dio = Dio(BaseOptions(baseUrl: "https://lunar-lms.onrender.com/api"));

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
  final Dio dio;
  AuthInterceptor(this.dio);
  bool _isRefreshing = false;
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
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = await TokenService.instance.getRefreshToken();
        if (refreshToken == null) {
          await TokenService.instance.clear();
        }
        final response = await dio.post("/auth/token/refresh/");
        final newToken = TokenModel.fromMap(response.data);

        final newAccess = response.data['access'];

        await TokenService.instance.save(newToken);
        final requestOptions = err.requestOptions;

        requestOptions.headers["Authoeization"] = "Bearer $newAccess";

        final cloneRespose = await dio.fetch(requestOptions);
        _isRefreshing = false;
        return handler.resolve(cloneRespose);
      } catch (e) {
        _isRefreshing = false;
        await TokenService.instance.clear();
        return handler.next(err);
      }
    }
    return handler.next(err);       
  }
}
