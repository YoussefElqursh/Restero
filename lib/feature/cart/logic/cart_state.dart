import 'package:restero/feature/cart/data/model/cart_model.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get total =>
      items.fold(0, (sum, cartItem) => sum + cartItem.item.price * cartItem.quantity);

  CartState copyWith({List<CartItem>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }
}
