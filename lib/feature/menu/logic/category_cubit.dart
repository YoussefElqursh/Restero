import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/menu/data/model/category_model.dart';
import 'package:restero/feature/menu/data/repository/category_repository.dart';


import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;
  CategoryCubit(this._categoryRepository) : super(CategoryState.initial());

  void listenToCategories() {
    _categoryRepository.getCategoriesStream().listen((categories) {
      if (!isClosed) {
        emit(CategoryState.success(categories));
      }
    });
  }

  Future<void> fetchCategoriesByIds(List<String> categoryIds) async {
    try {
      emit(CategoryState.loading());
      List<Categories> categories = [];

      for (var categoryId in categoryIds) {
        final category = await _categoryRepository.getCategoryById(categoryId);
        if (category != null) {
          categories.add(category);
        }
      }

      emit(CategoryState.success(categories)); // Emit list of categories
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }
}