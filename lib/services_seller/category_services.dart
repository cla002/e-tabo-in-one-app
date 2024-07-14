import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryListServicesSeller {
  Stream<QuerySnapshot> getCategoryList() {
    return FirebaseFirestore.instance.collection('categories').snapshots();
  }
}
