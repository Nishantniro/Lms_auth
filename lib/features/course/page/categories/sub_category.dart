import 'package:flutter/material.dart';
import 'package:lms/features/course/model/category.dart';

class SubCategory extends StatelessWidget {
  final CategoryModel parentCategory;
  final Function(CategoryModel) onSelect;
  const SubCategory({
    super.key,
    required this.parentCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final subCategory = parentCategory.children;
    if (subCategory.isEmpty) {
      return Center(child: Text("No subcategory"));
    }
    return ListView.builder(
      itemCount: subCategory.length,
      itemBuilder: (context, index) {
        final category = subCategory[index];
        return ListTile(
          title: Text(category.name),
          subtitle: Text(category.fullPath!),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            onSelect(category);
          },
        );
      },
    );
  }
}
