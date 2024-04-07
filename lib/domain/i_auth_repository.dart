import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<UserCredential> signInWithUserIdAndPassword(
      String emailId, String password);

  Future<UserCredential> signInWithGoogle();

  Future<UserCredential> signUpWithUserIdAndPassword(
      String emailId, String password);

  Future<void> logoutUser();
  Future<void> addUserToCollection(User user);
}
