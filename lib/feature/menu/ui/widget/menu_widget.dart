import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/cart/logic/cart_cubit.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';

class BuildMenuWidget extends StatefulWidget {
  final Item item;

  const BuildMenuWidget({super.key, required this.item});

  @override
  State<BuildMenuWidget> createState() => _BuildMenuWidgetState();
}

class _BuildMenuWidgetState extends State<BuildMenuWidget> {
  Item get item => widget.item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: MaterialButton(
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        height: 100,
        minWidth: MediaQuery.sizeOf(context).width - 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 135,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEBEBEB),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              height: 135.0,
              width: MediaQuery.sizeOf(context).width - 160,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: Color(0xFFAFAFAF),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'EGP ${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'EGP ${item.discount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xFFE02C45),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: Color(0xFFE02C45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  MaterialButton(
                    onPressed: () {
                      context.read<CartCubit>().addItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item added to cart')),
                      );
                    },
                    color: Color(0xFFCC5920),
                    minWidth: MediaQuery.sizeOf(context).width - 140,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    focusElevation: 0.0,
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
