import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restero/feature/cart/data/model/cart_model.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: []));

  void addItem(Item item) {
    final index = state.items.indexWhere((e) => e.item.itemId == item.itemId);
    if (index >= 0) {
      final updated = state.items[index]
          .copyWith(quantity: state.items[index].quantity + 1);
      final items = List<CartItem>.from(state.items)
        ..[index] = updated;
      emit(state.copyWith(items: items));
    } else {
      emit(state.copyWith(
        items: [...state.items, CartItem(item: item, quantity: 1)],
      ));
    }
  }

  void removeItem(String itemId) {
    final index = state.items.indexWhere((e) => e.item.itemId == itemId);
    if (index >= 0) {
      final current = state.items[index];
      if (current.quantity > 1) {
        final updated = current.copyWith(quantity: current.quantity - 1);
        final items = List<CartItem>.from(state.items)
          ..[index] = updated;
        emit(state.copyWith(items: items));
      } else {
        final items = List<CartItem>.from(state.items)
          ..removeAt(index);
        emit(state.copyWith(items: items));
      }
    }
  }

  void clearCart() {
    emit(CartState(items: []));
  }
}
