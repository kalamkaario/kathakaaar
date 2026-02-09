import 'package:kathakaar/models/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel?> signInWithGoogle();
  Future<void> signOut();
  UserModel? get currentUser;
}

class MockAuthRepository implements AuthRepository {
  UserModel? _user;

  @override
  Stream<UserModel?> get authStateChanges async* {
    yield _user;
  }

  @override
  UserModel? get currentUser => _user;

  @override
  Future<UserModel?> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    _user = UserModel(
      id: 'mock_user_123',
      email: 'poet@kathakaar.com',
      displayName: 'Kabir',
      photoUrl: 'https://ui-avatars.com/api/?name=Kabir&background=B3001B&color=fff',
      bio: 'Weaving words into silence.',
      languages: ['Hindi', 'English'],
    );
    return _user;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _user = null;
  }
}
