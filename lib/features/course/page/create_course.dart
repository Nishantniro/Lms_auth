import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms/features/course/bloc/get_category/get_category_bloc.dart';
import 'package:lms/features/course/model/category.dart';
import 'package:lms/features/course/page/categories/main_category.dart';
import 'package:lms/features/course/page/categories/sub_category.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({super.key});
  static const String routeName = "/create-course";

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  late final PageController _controller;
  CategoryModel? selectedMainCategory;
  CategoryModel? selectedSubCategory;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<GetCategoryBloc>().add(GetCategoryEvent());
    super.didChangeDependencies();
  }

  Widget buildBreadcrumbs() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (selectedMainCategory != null)
            Text(
              selectedMainCategory!.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

          if (selectedSubCategory != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.chevron_right, size: 18),
            ),

            Text(
              selectedSubCategory!.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create your course")),

      body: Column(
        crossAxisAlignment: .start,
        children: [
          IconButton(
            onPressed: () {
              final currentPage = _controller.page?.round() ?? 0;
              if (currentPage == 0) return;
              if (currentPage == 1) {
                setState(() {
                  selectedMainCategory = null;
                  selectedSubCategory = null;
                });
              }
              if (currentPage == 2) {
                setState(() {
                  selectedSubCategory = null;
                });
              }
              _controller.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            icon: Icon(Icons.chevron_left),
          ),

          buildBreadcrumbs(),
          BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategoryLoaded) {
                if (state.categoryModel.isEmpty) {
                  return Center(child: Text("No categories found"));
                }

                return Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      // child: IconButton(
                      //   onPressed: () {
                      //     _controller.previousPage(
                      //       duration: Duration(milliseconds: 300),
                      //       curve: Curves.easeIn,
                      //     );
                      //   },
                      //   icon: Icon(Icons.chevron_left),
                      // ),
                      //     ),
                      //   ],
                      // ),
                      MainCategory(
                        onSelect: (category) {
                          setState(() {
                            selectedMainCategory = category;
                          });

                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                      selectedMainCategory == null
                          ? const Center(child: Text("Select a main category"))
                          : SubCategory(
                              parentCategory: selectedMainCategory!,
                              onSelect: (category) {
                                setState(() {
                                  selectedSubCategory = category;
                                });

                                if (category.isLeaf!) {
                                  _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                            ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
