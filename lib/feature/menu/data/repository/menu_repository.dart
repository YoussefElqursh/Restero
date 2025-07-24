import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';

class MenuRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateItemAvailability(Item item, bool available) async {
    debugPrint('Item details: ${item.toJson()}');
    try {
      await _firestore.collection('items').doc(item.itemId).update({
        'available': available,
      });
    } catch (e) {
      debugPrint('Error updating item availability: $e');
    }
  }

  Future<List<Item>> fetchItems(List<String> itemIds) async {
    List<Item> items = [];
    Set<String> itemIdSet = itemIds.toSet();
    List<Future<void>> futures = [];
    final int batchSize = 20; // Batch size for Firestore queries

    try {
      for (int i = 0; i < itemIds.length; i += batchSize) {
        // Create batches of item IDs
        final batchIds = itemIds.sublist(
          i,
          i + batchSize > itemIds.length ? itemIds.length : i + batchSize,
        );

        // Add Firestore query as a future
        futures.add(
          _firestore
              .collection('items')
              .where(FieldPath.documentId, whereIn: batchIds)
              .get()
              .then((QuerySnapshot snapshot) {
            for (var doc in snapshot.docs) {
              Item item = Item.fromMap(doc.data() as Map<String, dynamic>);
              if (itemIdSet.contains(doc.id)) {
                items.add(item);
              }
            }
          }),
        );
      }

      // Wait for all futures to complete
      await Future.wait(futures);
    } catch (e) {
      debugPrint('Error fetching items: $e');
    }

    return items;
  }
}
