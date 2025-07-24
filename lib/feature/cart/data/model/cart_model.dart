import 'package:restero/feature/menu/data/model/item_model.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'quantity': quantity,
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      item: Item.fromMap(json['item']),
      quantity: json['quantity'],
    );
  }

  CartItem copyWith({
    Item? item,
    int? quantity,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }
}
