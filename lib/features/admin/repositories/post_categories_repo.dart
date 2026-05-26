import 'package:dartz/dartz.dart';
import 'package:lms/core/networks/dio_client.dart';
import 'package:lms/core/typedef/typedef.dart';
import 'package:lms/features/course/model/category.dart';

class PostCategoriesRepo {
  final DioClient _client = DioClient();

  FutureEither<String> postcategory(CategoryModel category) async {
    try {
      await _client.dio.post("admin/categories/", data: category.toMap());
      return Right("success fully added category");
    } catch (e) {
      rethrow;
    }
  }
}
