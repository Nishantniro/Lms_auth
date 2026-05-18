import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/features/auth/model/profile_model.dart';
import 'package:lms/features/auth/model/sign_up_model.dart';
import 'package:lms/features/auth/model/verify_otp_request_model.dart';
import 'package:lms/features/auth/model/verify_token_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient _dioClient = DioClient();

  Future<Either<String, String>> signup({required SignUpModel signup}) async {
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

  Future<Either<String, VerifyTokenResponseModel>> verifyopt({
    required VerifyOtpRequestModel verify,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        "/auth/verify-email/",
        data: verify.toMap(),
      );
      final finaldata = VerifyTokenResponseModel.fromMap(response.data);
      return right(finaldata);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("access_token");
      final response = await _dioClient.dio.get(
        "/profile/me",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      final finaldata = ProfileModel.fromMap(response.data);
      return right(finaldata);
    } catch (e) {
      return left(ErrorHandler.handelError(e));
    }
  }
}
