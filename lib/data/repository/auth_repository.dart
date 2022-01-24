import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(email, password) async {
    var cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (cred.user != null) {
      return cred.user!;
    }
  }

  Future<User?> signIn(email, password) async {
    var cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (cred.user != null) {
      return cred.user!;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> listenAuth() {
    return _auth.userChanges();
  }
}
