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
    AuthCredential credential = await fetchGoogleUserCredential();

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    debugPrint("signed in " + user.displayName);
  }

  static void linkWithGoogle() async {
    final AuthCredential credential = await fetchGoogleUserCredential();
    final FirebaseUser user = await _auth.currentUser();
    user.linkWithCredential(credential);
  }

  static Future<AuthCredential> fetchGoogleUserCredential() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    return GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  static void signInWithGithub() {
    _authOauth.openSignInFlow(
        "github.com", ["email"], {"locale": "en"}).catchError((e) => print(e));
  }

  static void linkWithGithub() async {
    _auth.currentUser().then((currentUser) {
      _authOauth.openSignInFlow("github.com", ["email"], {"locale": "en"}).then(
        (value) async {
          final token = (await value.getIdToken()).token;

          final credential = GithubAuthProvider.getCredential(token: token);
          currentUser.linkWithCredential(credential);
        },
      ).catchError((e) => print(e));
    });
  }

  static Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  static void signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }
}
