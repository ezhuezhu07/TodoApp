import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  String userUID = '';
  // UserCredential authResult;
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      userUID = authResult.user!.uid;
      return authResult;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'username': authResult.user!.email!.split('@')[0],
        'email': authResult.user!.email!,
      });
      userUID = authResult.user!.uid;
      return authResult;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }
}
