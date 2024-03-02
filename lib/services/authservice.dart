import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/chatroom.dart';
import 'package:flutter_application_1/shared/custom_error.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? signInAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication authentication =
          await signInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken);

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      return user;
    } catch (e) {
      return CustomError(error: 'Error Signing In!');
    }
  }

  Future? signOutWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await auth.signOut();
      return null;
    } catch (e) {
      return CustomError(error: 'Error Signing Out!');
    }
  }

  Stream<User?> get userStream {
    return auth.authStateChanges();
  }
}
