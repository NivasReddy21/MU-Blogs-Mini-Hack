import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<dynamic> signInWithGoogle() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var data = {
      'name': googleUser.displayName,
      'photoUrl': googleUser.photoUrl,
      'id': googleUser.id
    };

    await _prefs.setString("name", googleUser.displayName!);
    await _prefs.setString("photoUrl", googleUser.photoUrl!);
    await _prefs.setString("id", googleUser.id);

    DocumentSnapshot userRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(googleUser.displayName)
        .get();

    if (!userRef.exists) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(googleUser.displayName)
          .set(data);
    }

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    return await FirebaseAuth.instance.currentUser!
        .updateDisplayName(googleUser.displayName);
  }
}
