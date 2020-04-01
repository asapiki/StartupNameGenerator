import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserModel extends ChangeNotifier {
  FirebaseUser _user;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser get user => _user;
  bool get isLoggedIn => _user != null;

  void signInWithGoogle() {
    _handleSignInWithGoogle().then((FirebaseUser user) {
      _user = user;
      notifyListeners();
    }).catchError((e) => print(e));
  }

  Future<FirebaseUser> _handleSignInWithGoogle() async {
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
    return user;
  }

  void signInWithGithub() async {
    FirebaseAuthOAuth().openSignInFlow(
        "github.com", ["email"], {"locale": "en"}).then((FirebaseUser user) {
      _user = user;
      notifyListeners();
    }).catchError((e) => print(e));
  }

  void signInWithEmail(String email, String password) {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((authResult) {
      _user = authResult.user;
      notifyListeners();
    }).catchError((e) => print(e));
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
