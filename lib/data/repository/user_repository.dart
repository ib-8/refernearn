import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:refer_n_earn/data/model/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future getUser(String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return User.fromMap(snapshot.data()!);
  }
}
