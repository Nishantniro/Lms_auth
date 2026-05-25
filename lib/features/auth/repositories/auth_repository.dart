import 'package:dartz/dartz.dart';
import 'package:lms/core/data/storage/token_service.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/core/typedef/typedef.dart';
import 'package:lms/features/auth/model/login_model.dart';
import 'package:lms/features/auth/model/sign_up_model.dart';
import 'package:lms/features/auth/model/token_model.dart';
// import 'package:lms/features/auth/model/token_model.dart';
import 'package:lms/features/auth/model/verify_otp_request_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient();

  FutureEither<String> signup({required SignUpModel signup}) async {
    try {
      final response = await _dioClient.dio.post(
        "/auth/sign-up/",
        data: signup.toMap(),
      );
      return Right(response.data["detail"]);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }

  FutureEither<TokenModel> verifyopt({
    required VerifyOtpRequestModel verify,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        "/auth/verify-email/",
        data: verify.toMap(),
      );

      final finaldata = TokenModel.fromMap(response.data['token']);
      await TokenService.instance.save(finaldata);

      return right(finaldata);
    } catch (e) {
      return left(e.toString());
    }
  }

  FutureEither<String> login({required LoginModel login}) async {
    try {
      final response = await _dioClient.dio.post(
        "/auth/login/",
        data: login.toMap(),
      );
      final token = TokenModel.fromMap(response.data["token"]);
      await TokenService.instance.save(token);
      return Right(response.data["detail"]);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }

  FutureEither<String> refresh(String refresh) async {
    try {
      final response = await _dioClient.dio.post(
        "/auth/token/refresh/",
        data: {"refresh": refresh},
      );
      final token = TokenModel.fromMap(response.data);
      await TokenService.instance.save(token);
      return Right(response.data);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }
}
