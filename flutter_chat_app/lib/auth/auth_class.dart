import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/custom_text.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass {
  //Sign In With Google

  Future signInWitGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExists = await firebaseFirestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userExists.exists) {
      print('User Already Exists In Database.');
    } else {
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'image': userCredential.user!.photoURL,
        'uid': userCredential.user!.uid,
        'date': DateTime.now(),
        'phoneNumber': userCredential.user!.phoneNumber,
      });
      }
  }

  //Sign In With Email And Password

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  //Sign Up With Email And Password

  Future signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  //Sign Out

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
