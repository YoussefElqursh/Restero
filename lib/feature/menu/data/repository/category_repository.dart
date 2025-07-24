import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restero/feature/menu/data/model/category_model.dart' as category_model;

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<category_model.Categories?>> getCategoriesStream() {
    return _firestore.collection('categories').snapshots().map(
          (snapshot) {
        return snapshot.docs
            .map(
              (doc) => category_model.Categories.fromJson(
            doc.data(),
          ),
        )
            .toList();
      },
    );
  }

  Future<category_model.Categories?> getCategoryById(String categoryId) async {
    final doc = await _firestore.collection('categories').doc(categoryId).get();
    if (doc.exists) {
      return category_model.Categories.fromJson(doc.data()!);
    }
    return null;
  }
}
