import 'package:tesisApp/data/dto/models/category.dart';

class MenuResponseDto {
  final List<Category> categories;

  MenuResponseDto({
    required this.categories,
  });

  factory MenuResponseDto.fromJson(Map<String, dynamic> json) {
    final jsonCategories = (json['categories'] ?? []) as List;
    final List<Category> categoriesList =
        jsonCategories.map((e) => Category.fromMap(e)).toList();
    return MenuResponseDto(
      categories: categoriesList,
    );
  }
}
