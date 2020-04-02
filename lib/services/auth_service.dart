import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuthOAuth _authOauth = FirebaseAuthOAuth();

  static void signInAsAnonymous() {
    _auth.signInAnonymously().catchError((error) {
      debugPrint(error);
    });
  }

  static void signInWithEmail(String email, String password) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) => print(e));
  }

  static void signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    debugPrint("signed in " + user.displayName);
  }

  static void signInWithGithub() {
    _authOauth.openSignInFlow(
        "github.com", ["email"], {"locale": "en"}).catchError((e) => print(e));
  }

  static Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  static void signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }
}
