import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/admin/repositories/post_categories_repo.dart';
import 'package:lms/features/course/model/category.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final PostCategoriesRepo _repo = PostCategoriesRepo();
  AddCategoryBloc() : super(AddCategoryInitial()) {
    on<AddCategoryEvent>((event, emit) async {
      final result = await _repo.postcategory(event.categoryModel);
      result.fold(
        (l) => emit(AddCategoryError(msg: l)),
        (r) => emit(AddCategoryLoaded(msg: "sucessfully loaded")),
      );
    });
  }
}
