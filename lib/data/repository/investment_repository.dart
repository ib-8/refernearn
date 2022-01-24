import 'package:cloud_firestore/cloud_firestore.dart';

class InvestmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> invest(String id, Map<String, dynamic> data) async {
    await _firestore
        .collection('users')
        .doc(id)
        .collection('investments')
        .add(data);
  }
}
