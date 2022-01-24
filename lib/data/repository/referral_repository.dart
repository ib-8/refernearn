import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:refer_n_earn/data/model/referral.dart';
import 'package:refer_n_earn/data/model/user.dart';

class ReferralRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Referral>> getReferrals(String id) async {
    var snapshot = await _firestore
        .collection('users')
        .doc(id)
        .collection('referral')
        .get();

    return snapshot.docs.map((doc) => Referral.fromMap(doc.data())).toList();
  }

  Future<User?> checkReferralCode(String code) async {
    var snapshot = await _firestore
        .collection('users')
        .where('referralCode', isEqualTo: code)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return User.fromMap(snapshot.docs.first.data());
    }
  }

  Future<void> addReferral({
    required String referrarId,
    required Referral referral,
  }) async {
    await _firestore
        .collection('users')
        .doc(referrarId)
        .collection('referral')
        .doc(referral.id)
        .set(referral.toMap());
  }

  Future<void> updateReferral({
    required String referrarId,
    required Map<String, dynamic> data,
    required String currentUserId,
  }) async {
    await _firestore
        .collection('users')
        .doc(referrarId)
        .collection('referral')
        .doc(currentUserId)
        .update(data);
  }
}
