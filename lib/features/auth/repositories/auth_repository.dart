import 'package:dartz/dartz.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/features/auth/model/sign_up_model.dart';

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
}
