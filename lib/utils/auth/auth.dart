import 'package:chat_app/main.dart';
import 'package:chat_app/views/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
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
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //Sign Up With Email And Password

  Future signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
    required String imageUrl,
    required String phoneNumber,
  }) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      await firebaseFirestore.collection('users').doc(user!.uid).set({
        'email': email,
        'name': name,
        'imageUrl': imageUrl,
        'uid': user.uid,
        'phoneNumber': phoneNumber,
        'date': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }

  //Sign Out

  Future signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  //Sign In With Google

  Future signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      return;
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExsits = await firebaseFirestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userExsits.exists) {
      print('User already exsits in database.');
    } else {
      await firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'imageUrl': userCredential.user!.photoURL,
        'uid': userCredential.user!.uid,
        'phoneNumber': userCredential.user!.phoneNumber,
        'date': DateTime.now(),
      });
    }
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  //
}
