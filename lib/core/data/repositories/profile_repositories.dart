import 'package:dartz/dartz.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/features/auth/model/profile_model.dart';

class ProfileRepositories {
  final DioClient _dioClient = DioClient();
  Future<Either<String, ProfileModel>> getProfile() async {
    try {
      // final prefs = await SharedPreferences.getInstance();

      // final token = prefs.getString("access_token");
      final response = await _dioClient.dio.get("/profile/me/");
      final finaldata = ProfileModel.fromMap(response.data);
      return right(finaldata);
    } catch (e) {
      return left(ErrorHandler.handelError(e));
    }
  }
}
