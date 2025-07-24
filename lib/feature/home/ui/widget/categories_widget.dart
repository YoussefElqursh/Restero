import 'package:flutter/material.dart';
import 'package:restero/feature/menu/data/model/category_model.dart';

Widget buildCategoriesWidget(Categories category) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x0CE02C45),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(left: 5, bottom: 10, right: 5),
                child: Text(
                  category.categoryName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: 70,
        height: 70,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Image.network(
          category.categoryImage,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}
