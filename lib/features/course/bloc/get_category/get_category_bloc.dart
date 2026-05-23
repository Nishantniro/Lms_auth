import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/course/model/category.dart';
import 'package:lms/features/course/repositories/course_repository.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final CourseRepository repo;
  GetCategoryBloc(this.repo) : super(GetCategoryInitial()) {
    on<FetchCategories>(_fetchCategories);
  }
  Future<void> _fetchCategories(
    FetchCategories event,
    Emitter<GetCategoryState> emit,
  ) async {
    emit(GetCategoryLoading());
    final result = await repo.getCategoryTree();
    result.fold(
      (l) => emit(GetCategoryFailure(msg: l)),
      (categories) => emit(GetCategoryLoaded(categoryModel: categories)),
    );
  }
}
