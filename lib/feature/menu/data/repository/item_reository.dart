import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restero/feature/menu/data/model/item_model.dart';

class ItemRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Item>> getItems(List<String> itemIds) async {
    List<Item> items = [];
    Set<String> itemIdSet = itemIds.toSet();
    List<Future<void>> futures = [];

    for (int i = 0; i < itemIds.length; i += 20) {
      // Adjusted batch size to 20
      final batchIds =
      itemIds.sublist(i, i + 20 > itemIds.length ? itemIds.length : i + 20);

      futures.add(
        firestore
            .collection('items')
            .where(FieldPath.documentId, whereIn: batchIds)
            .get()
            .then(
              (QuerySnapshot snapshot) {
            for (var doc in snapshot.docs) {
              Item item = Item.fromMap(doc.data() as Map<String, dynamic>);
              if (item.available && itemIdSet.contains(doc.id)) {
                items.add(item);
              }
            }
          },
        ),
      );
    }

    await Future.wait(futures);
    return items;
  }
}
