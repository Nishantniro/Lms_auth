part of 'get_category_bloc.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryLoading extends GetCategoryState {}

final class GetCategoryLoaded extends GetCategoryState {
  final List< CategoryModel> categoryModel;

  const GetCategoryLoaded({required this.categoryModel});

   @override
  List<Object> get props => [categoryModel];
}

final class GetCategoryFailure extends GetCategoryState {
  final String msg;

  const GetCategoryFailure({required this.msg});
  @override
  List<Object> get props => [msg];
}
