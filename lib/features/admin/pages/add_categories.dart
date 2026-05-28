import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/core/extension/context_extesion.dart';
import 'package:lms/core/widgets/custom_text_form.dart';
import 'package:lms/core/widgets/primary_button.dart';
import 'package:lms/features/admin/bloc/add_category/add_category_bloc.dart';
import 'package:lms/features/course/bloc/get_category/get_category_bloc.dart';
import 'package:lms/features/course/model/category.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});
  static const String routeName = "/add_category";

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GetCategoryBloc>().add(GetCategoryEvent());
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  CategoryModel? selectedParent;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    slugController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add category ")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            BlocBuilder<GetCategoryBloc, GetCategoryState>(
              builder: (context, state) {
                if (state is GetCategoryLoading) {
                  return SizedBox(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.black,
                      size: 25,
                    ),
                  );
                }
                if (state is GetCategoryLoaded) {
                  return DropdownButtonFormField<CategoryModel>(
                    initialValue: selectedParent,
                    decoration: const InputDecoration(
                      labelText: "Parent Category",
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text("Select Parent Category"),

                    items: state.categoryModel.map((category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedParent = value;
                      });
                    },
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            Text("category name", style: TextStyle(fontSize: 24)),
            CustomTextForm(
              controller: nameController,
              prefixIcon: Icon(Icons.library_books_sharp),
            ),
            SizedBox(),
            Text("slug", style: TextStyle(fontSize: 24)),
            CustomTextForm(
              controller: slugController,
              prefixIcon: Icon(Icons.lightbulb),
            ),
            SizedBox(),
            Text("description", style: TextStyle(fontSize: 24)),
            CustomTextForm(
              controller: descriptionController,
              prefixIcon: Icon(Icons.calendar_month),
            ),
            SizedBox(),
            SizedBox(height: 20),

            BlocListener<AddCategoryBloc, AddCategoryState>(
              listener: (context, state) {
                if (state is AddCategoryError) {
                  context.showSnackbar(state.msg);
                } else if (state is AddCategoryLoading) {
                  context.showLoadingDialog();
                } else if (state is AddCategoryLoaded) {
                  context.pop();
                  context.showSnackbar(state.msg);
                  context.pop();
                }
              },
              child: PrimartButton(
                lableText: "Apply",
                onpressed: () {
                  final category = CategoryModel(
                    parent: selectedParent?.id,
                    name: nameController.text,
                    slug: slugController.text,
                    description: descriptionController.text,
                    isActive: true,
                  );
                  context.read<AddCategoryBloc>().add(
                    AddCategoryEvent(categoryModel: category),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
