part of 'add_category_bloc.dart';

sealed class AddCategoryState extends Equatable {
  const AddCategoryState();

  @override
  List<Object> get props => [];
}

final class AddCategoryInitial extends AddCategoryState {}

final class AddCategoryLoading extends AddCategoryState {}

final class AddCategoryLoaded extends AddCategoryState {}

final class AddCategoryError extends AddCategoryState {
  final String msg;

  const AddCategoryError({required this.msg});
  @override
  List<Object> get props => [msg];
}
