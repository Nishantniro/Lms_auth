part of 'add_category_bloc.dart';

class AddCategoryEvent extends Equatable {
  final CategoryModel categoryModel;
  const AddCategoryEvent({required this.categoryModel});

  @override
  List<Object> get props => [categoryModel];
}
