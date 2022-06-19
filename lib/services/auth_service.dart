import 'package:firebase_auth/firebase_auth.dart';
import 'package:guitar_corner_app/my_widgets/my_widgets.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future createUser(String email, String pass) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      MyDialog.alertDialog(e);
      return false;
    } catch (e) {
      MyDialog.alertDialog(e);
      return false;
    }
  }

  static Future logIn(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      MyDialog.alertDialog(e);
      return false;
    } catch (e) {
      MyDialog.alertDialog(e);
      return false;
    }
  }

  static getCurrentEmail() {
    final user = _auth.currentUser;

    if (user != null) {
      final emailUser = user.email;
      return emailUser;
    }

    return false;
  }

  static Future updateUserEmail(String newEmail, String pass) async {
    final user = _auth.currentUser;

    try {
      if (user != null) {
        await _auth
            .signInWithEmailAndPassword(
          email: user.email.toString(),
          password: pass,
        )
            .then((dataCredential) {
          dataCredential.user?.updateEmail(newEmail);
        });
      }
      return true;
    } on FirebaseAuthException catch (e) {
      MyDialog.alertDialog(e);
      return false;
    }
  }

  static Future changePassword(String oldPass, String newPass) async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        await _auth
            .signInWithEmailAndPassword(
          email: user.email.toString(),
          password: oldPass,
        )
            .then((dataCredential) {
          dataCredential.user?.updatePassword(newPass);
        });
      }
      return true;
    } on FirebaseAuthException catch (e) {
      MyDialog.alertDialog(e);
      return false;
    } catch (e) {
      MyDialog.alertDialog(e);
      return false;
    }
  }

  static signOut() {
    _auth.signOut();
  }
}
