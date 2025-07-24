import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/home/ui/widget/categories_widget.dart';
import 'package:restero/feature/menu/data/model/category_model.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';
import 'package:restero/feature/menu/data/repository/category_repository.dart';
import 'package:restero/feature/menu/data/repository/item_reository.dart';
import 'package:restero/feature/menu/logic/category_cubit.dart';
import 'package:restero/feature/menu/logic/category_state.dart';
import 'package:restero/feature/menu/ui/widget/menu_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  List<Item?> allItems = [];
  List<Categories?> categories = [];

  final List<String> adsImageList = [
    "assets/images/restero_app_icon.jpg",
    "assets/images/restero_app_icon.jpg",
    "assets/images/restero_app_icon.jpg",
    "assets/images/restero_app_icon.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    CategoryRepository categoryRepository = CategoryRepository();
    // Wait for restaurant data before providing the Bloc
    ItemRepository itemRepository = ItemRepository();
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
              Future<List<Item>> items = itemRepository.getItems([
                'wJigGLmuctMZN75IhDR3',
                'z6YwljjfB2umYnP528uk',
                'M457qxrO3vYj52QCGdHY',
              ]);

              items.then((itemList) {
                setState(() {
                  allItems = itemList;
                  this.categories = categories;
                });
              });
              return Scaffold(
                appBar: AppBar(title: const Text('Home')),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ads Part
                    CarouselSlider(
                      items: adsImageList
                          .map(
                            (e) => Center(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage(e),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (value, _) {
                          _currentPageNotifier.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    ValueListenableBuilder<int>(
                      valueListenable: _currentPageNotifier,
                      builder: (context, currentPage, _) {
                        return Container(
                          width: MediaQuery.sizeOf(context).width,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(adsImageList.length, (i) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: i == currentPage
                                      ? const Color(0xFFE02C45)
                                      : Theme.of(context).brightness ==
                                            Brightness.light
                                      ? const Color(0x0CE02C45)
                                      : const Color(0x5FE02C45),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 25.0),
                    // All Categories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'All Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100.0,
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildCategoriesWidget(categories[index]!),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10.0),
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    // All Items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'All Items',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            BuildMenuWidget(item: allItems[index]!),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, color: Colors.grey),
                        itemCount: allItems.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
