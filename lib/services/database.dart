import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(
    Map<String, dynamic> userInfoMap,
    String userId,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<DocumentReference<Map<String, dynamic>>> addProduct(
    Map<String, dynamic> productMap,
    String categoryName,
  ) async {
    return await FirebaseFirestore.instance
        .collection(categoryName)
        .add(productMap);
  }

  Stream<QuerySnapshot> getProducts(String category) {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future<void> addOrder(Map<String, dynamic> orderInfoMap, String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .add(orderInfoMap);
  }

  Stream<QuerySnapshot> getOrders(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .snapshots();
  }

  Future<void> deleteOrder(String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Orders")
        .doc(orderId)
        .delete();
  }
}
