import 'package:flutter/material.dart';
import 'package:kathakaar/models/user_model.dart';
import 'package:kathakaar/repositories/auth_repository.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, authenticating }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  AuthStatus _status = AuthStatus.uninitialized;
  UserModel? _user;

  AuthProvider(this._authRepository) {
    _checkCurrentUser();
  }

  AuthStatus get status => _status;
  UserModel? get user => _user;

  Future<void> _checkCurrentUser() async {
    _user = _authRepository.currentUser;
    if (_user != null) {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();

      final user = await _authRepository.signInWithGoogle();
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
