class CategoryModel {
  final String? id;
  final String? parent;
  final String name;
  final String slug;
  final String description;
  final bool isActive;
  final String? childrenCount;
  final bool? isLeaf;
  final String? fullPath;
  final List<CategoryModel> children;

  CategoryModel({
    this.id,
    this.parent,
    required this.name,
    required this.slug,
    required this.description,
    required this.isActive,
    this.childrenCount,
    this.isLeaf,
    this.fullPath,
    this.children = const [],
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      parent: map['parent'],
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      description: map['description'] ?? '',
      isActive: map['is_active'] ?? false,
      childrenCount: map['children_count'].toString(),
      isLeaf: map['is_leaf'] ?? false,
      fullPath: map['full_path'] ?? '',
      children: map['children'] != null
          ? List<CategoryModel>.from(
              (map['children'] as List).map((x) => CategoryModel.fromMap(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parent': parent,
      'name': name,
      'slug': slug,
      'description': description,
      'is_active': isActive,
    };
  }
}
