import 'package:dartz/dartz.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/features/trainer/model/apply_trainer_model.dart';
import 'package:lms/features/trainer/model/trainer_profile_model.dart';

class TrainerRepositories {
  final DioClient _client = DioClient();

  Future<Either<String, String>> applyForTrainer(
    ApplyTrainerModel apply,
  ) async {
    try {
      await _client.dio.post("/trainer/apply/", data: apply.toMap());

      return Right("success");
    } catch (e) {
      return left(ErrorHandler.handelError(e));
    }
  }

  Future<Either<String, TrainerProfileModel>> gettrainerProfile() async {
    try {
      final response = await _client.dio.get("/trainer/me/");

      final TrainerProfileModel result = TrainerProfileModel.fromMap(
        response.data,
      );
      return Right(result);
    } catch (e) {
      return left(ErrorHandler.handelError(e));
    }
  }
}
