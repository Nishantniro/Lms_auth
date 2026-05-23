import 'package:dartz/dartz.dart';
import 'package:lms/core/error/error_handler.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/core/typedef/typedef.dart';
import 'package:lms/features/course/model/category.dart';

class CourseRepository {
  final DioClient _repo = DioClient();
  FutureEither<List<CategoryModel>> getCategories() async {
    try {
      final response = await _repo.dio.get("/courses/categories/");
      final categories = List.from(
        response.data,
      ).map((e) => CategoryModel.fromMap(e)).toList();
      return Right(categories);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }

  FutureEither<List<CategoryModel>> getCategoryTree() async {
    try {
      final response = await _repo.dio.get("/courses/categories/tree/");
      final categories = List.from(
        response.data,
      ).map((e) => CategoryModel.fromMap(e)).toList();
      return Right(categories);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }

  FutureEither<CategoryModel> getCategoryDetail(String slug) async {
    try {
      final response = await _repo.dio.get("/courses/categories/$slug/");
      final category = CategoryModel.fromMap(response.data);
      return Right(category);
    } catch (e) {
      return Left(ErrorHandler.handelError(e));
    }
  }
}
