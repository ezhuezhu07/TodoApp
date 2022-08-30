import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  // UserCredential authResult;
  static Future<UserCredential?> signIn(String email, String password) async {
    final auth = FirebaseAuth.instance;
    String userUID = '';
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

  static Future<UserCredential?> signUp(String email, String password) async {
    final auth = FirebaseAuth.instance;
    String userUID = '';
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

  static Future googleLogin() async {
    final googleSignIn = GoogleSignIn();

    GoogleSignInAccount? user;
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
