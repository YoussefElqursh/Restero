import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';
import 'package:restero/feature/menu/data/repository/category_repository.dart';
import 'package:restero/feature/menu/data/repository/menu_repository.dart';
import 'package:restero/feature/menu/logic/category_cubit.dart';
import 'package:restero/feature/menu/logic/category_state.dart';
import 'package:restero/feature/menu/ui/widget/menu_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Item> items = [];
  final MenuRepository _menuRepository = MenuRepository();
  List<String> category = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final fetchedItems = await _menuRepository.fetchItems([
      'wJigGLmuctMZN75IhDR3',
      'z6YwljjfB2umYnP528uk',
      'M457qxrO3vYj52QCGdHY',
    ]);
    setState(() {
      items = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryRepository categoryRepository = CategoryRepository();
    // Wait for restaurant data before providing the Bloc
    return BlocProvider(
      create: (_) {
        final cubit = CategoryCubit(categoryRepository);
        cubit.listenToCategories();
        return cubit;
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, cState) {
          return cState.when(
            initial: () => const Center(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFFCC5920)),
                ),
              ),
            ),
            loading: () => const Center(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFFCC5920)),
                ),
              ),
            ),
            error: (error) => const Center(child: Text('err')),
            addedSuccessfully: () => const Center(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: Color(0xFFCC5920)),
                ),
              ),
            ),
            success: (categories) {
              category = categories
                  .where(
                    (category) => category?.categoryName != null,
                  ) // Remove null categories and null names
                  .map((category) => category!.categoryName)
                  .toList();
              return DefaultTabController(
                length: category.length,
                child: Scaffold(
                  appBar: _buildAppBar(),
                  body: _buildBody(category),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Menu',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: SizedBox.shrink(),
    );
  }

  Widget _buildBody(List<String> categories) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            children: categories.map((category) {
              final categoryItems = items
                  .where((item) => item.category == category)
                  .toList();
              return _buildMealList(categoryItems);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      isScrollable: false,
      dividerColor: const Color(0xFFDFD2C9),
      unselectedLabelColor: const Color(0xFFDFD2C9),
      unselectedLabelStyle: const TextStyle(
        color: Color(0xFFDFD2C9),
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      labelColor: const Color(0xFFCC5920),
      labelStyle: const TextStyle(
        color: Color(0xFFCC5920),
        fontSize: 12,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
      ),
      indicatorColor: const Color(0xFFCC5920),
      tabs: [for (int i = 0; i < category.length; i++) Tab(text: category[i])],
    );
  }

  Widget _buildMealList(List<Item> categoryItems) {
    if (categoryItems.isEmpty) {
      return _buildEmptyState();
    }
    return ListView.separated(
      itemBuilder: (context, index) =>
          BuildMenuWidget(item: categoryItems[index]),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: Colors.grey),
      itemCount: categoryItems.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fastfood, size: 70),
          const SizedBox(height: 15),
          const Text(
            'No Items Available',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
