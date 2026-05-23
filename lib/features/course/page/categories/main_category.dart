import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/course/bloc/get_category/get_category_bloc.dart';
import 'package:lms/features/course/model/category.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainCategory extends StatelessWidget {
  final Function(CategoryModel) onSelect;
  const MainCategory({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoryBloc, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoading) {
          return Center(
            child: LoadingAnimationWidget.twistingDots(
              leftDotColor: Colors.black,
              rightDotColor: Colors.purpleAccent,
              size: 30,
            ),
          );
        }
        if (state is GetCategoryLoaded) {
          return ListView.builder(
            itemCount: state.categoryModel.length,
            itemBuilder: (context, index) {
              final catogary = state.categoryModel[index];

              return ListTile(
                title: Text(catogary.name),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  onSelect(catogary);
                },
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
