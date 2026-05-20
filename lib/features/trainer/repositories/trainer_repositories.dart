import 'package:dartz/dartz.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/features/trainer/model/apply_trainer_model.dart';

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
}
