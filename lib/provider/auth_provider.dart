import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:refer_n_earn/data/model/user.dart';
import 'package:refer_n_earn/data/repository/auth_repository.dart';
import 'package:refer_n_earn/provider/referral_provider.dart';
import 'package:refer_n_earn/provider/user_provider.dart';
import 'package:refer_n_earn/ui/utils/keyboard_service.dart';

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
}

class AuthProvider extends ChangeNotifier {
  final UserProvider userProvider;
  final AuthRepository authRepository;
  bool isLoading = false;
  AuthState authState = AuthState.loading;

  AuthProvider({required this.authRepository, required this.userProvider}) {
    _listenAuthChange();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String? referralCode,
    required String password,
  }) async {
    KeyboardService.hide();
    isLoading = true;
    notifyListeners();
    try {
      auth.User? firebaseUser = await authRepository.signUp(email, password);

      if (firebaseUser != null) {
        User? referrar;
        if (referralCode != null) {
          referrar = await ReferralProvider.getReferrar(referralCode);
        }
        User user = User(
          name: name,
          email: email,
          id: firebaseUser.uid,
          referralCode: firebaseUser.uid.hashCode.toString(),
          referrarId: referrar?.id,
        );

        await userProvider.createUser(user);
        if (referralCode != null) {
          if (referrar != null) {
            await ReferralProvider.addReferral(referrar);
          } else {
            Fluttertoast.showToast(msg: 'Invalid Referral Code');
          }
        }

        authState = AuthState.authenticated;
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    KeyboardService.hide();
    isLoading = true;
    notifyListeners();

    try {
      var user = await authRepository.signIn(email, password);
      if (user != null) {
        await userProvider.getCurrentUser(user.uid);
        authState = AuthState.authenticated;
        notifyListeners();
        isLoading = false;
      } else {
        throw Exception();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    authState = AuthState.unauthenticated;
    notifyListeners();
  }

  late StreamSubscription authStream;

  Future<void> _listenAuthChange() async {
    authStream = authRepository.listenAuth().listen((user) async {
      if (user != null) {
        authState = AuthState.authenticated;
        await userProvider.getCurrentUser(user.uid);
        notifyListeners();
      } else {
        authState = AuthState.unauthenticated;
        notifyListeners();
      }
      if (authState != AuthState.loading) {
        authStream.cancel();
      }
    });
  }
}
