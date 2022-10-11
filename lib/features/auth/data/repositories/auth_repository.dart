import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRepository({required this.firebaseAuth, required this.googleSignIn});

  Future<User> signInUserAnonymously() async {
    try {
      final User? user = (await firebaseAuth.signInAnonymously()).user;
      return user!;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<User> signInUserWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken);
      User? user;
      User? isCurrentUser = await getUserSignedInStatus();

      if (isCurrentUser != null) {
        if (isCurrentUser.isAnonymous) {
          user = (await firebaseAuth.currentUser
                  ?.linkWithCredential(authCredential))!
              .user;
        }
      } else {
        user = (await firebaseAuth.signInWithCredential(authCredential)).user;
      }
      return user!;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<User?> getUserSignedInStatus() async {
    final User? user = firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOutUser() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
