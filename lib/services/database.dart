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
}
