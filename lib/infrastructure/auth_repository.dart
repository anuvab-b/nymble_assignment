import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nymble_assignment/domain/i_auth_repository.dart';

class AuthRepository implements IAuthRepository{
  late FirebaseAuth firebaseAuth;

  @override
  Future<UserCredential> signInWithUserIdAndPassword(
      String emailId, String password) async {
    late UserCredential userCredential;
    try {
      firebaseAuth = FirebaseAuth.instance;
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: emailId, password: password);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw ("The account already exists for that email.");
      } else {
        throw (e.message.toString());
      }
    } catch (e) {
      throw e.toString();
    }
    return userCredential;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    late UserCredential userCredential;
    try{
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        throw "Wrong password provided for that user.";
      } else if(e.code == "INVALID_LOGIN_CREDENTIALS"){
        throw "Invalid login credentials";
      }
      else {
        throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
    }
    return userCredential;
  }

  @override
  Future<UserCredential> signUpWithUserIdAndPassword(
      String emailId, String password) async {
    late UserCredential userCredential;
    try {
      firebaseAuth = FirebaseAuth.instance;
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailId, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw ("The account already exists for that email.");
      } else {
        throw (e.message.toString());
      }
    } catch (e) {
      throw (e.toString());
    }
    return userCredential;
  }

  @override
  Future<void> logoutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> addUserToCollection(User? user) async{
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.displayName)
        .set({"username": user?.displayName, "email-id": user?.email});
  }
}