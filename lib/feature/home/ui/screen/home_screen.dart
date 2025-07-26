import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restero/feature/home/ui/widget/categories_widget.dart';
import 'package:restero/feature/menu/data/model/category_model.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';
import 'package:restero/feature/menu/data/repository/category_repository.dart';
import 'package:restero/feature/menu/data/repository/item_reository.dart';
import 'package:restero/feature/menu/logic/category_cubit.dart';
import 'package:restero/feature/menu/logic/category_state.dart';
import 'package:restero/feature/menu/ui/widget/menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (_) {
        final cubit = CategoryCubit(CategoryRepository());
        cubit.listenToCategories();
        return cubit;
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, cState) {
          return cState.when(
            initial: _loadingScreen,
            loading: _loadingScreen,
            error: (error) => const Scaffold(
              body: Center(child: Text('Something went wrong')),
            ),
            addedSuccessfully: _loadingScreen,
            success: (categories) {
              return FutureBuilder<List<Item>>(
                future: ItemRepository().getItems([
                  'wJigGLmuctMZN75IhDR3',
                  'z6YwljjfB2umYnP528uk',
                  'M457qxrO3vYj52QCGdHY',
                ]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return _loadingScreen();

                  final items = snapshot.data!;

                  return Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 100.0.h,
                      leadingWidth: 200.0.w,
                      leading: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10.0.w,
                          children: [
                            Container(
                              height: 50.0.h,
                              width: 50.0.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                shape: BoxShape.rectangle,
                                color: Color(0xFFDFD2C9),
                              ),
                              child: const Icon(
                                Icons.person_2,
                                color: Color(0xFFCC5920),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10.0.h,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    color: Color(0xFFDFD2C9),
                                  ),
                                ),
                                SizedBox(
                                  width: 80.0.w,
                                  child: Text(
                                    user?.email?.split('@').first.toUpperCase() ?? '',
                                    style: TextStyle(
                                      fontSize: 16.0.sp,
                                      color: Color(0xFFCC5920),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.3,
                    ),
                    body: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(child: _buildCarousel(context)),
                          const SliverToBoxAdapter(child: SizedBox(height: 20)),
                          _buildSectionTitle('All Categories'),
                          SliverToBoxAdapter(
                            child: _buildCategoriesList(categories),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 20)),
                          _buildSectionTitle('All Items'),
                          SliverList.separated(
                            itemBuilder: (_, i) =>
                                BuildMenuWidget(item: items[i]),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: items.length,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _loadingScreen() => const Scaffold(
    body: Center(child: CircularProgressIndicator(color: Color(0xFFCC5920))),
  );

  Widget _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(List<Categories?> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) =>
            buildCategoriesWidget(categories[index]!),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final adsImageList = [
      "assets/images/restero_app_icon.jpg",
      "assets/images/restero_app_icon.jpg",
      "assets/images/restero_app_icon.jpg",
    ];

    return Column(
      children: [
        CarouselSlider(
          items: adsImageList.map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                e,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            height: 160,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
        const SizedBox(height: 8),
        // Optional: Add dots indicator here if needed
      ],
    );
  }
}
