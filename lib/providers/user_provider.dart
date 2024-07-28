import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/models/user.dart';
import 'package:e_shop/utils/common.dart';
import 'package:e_shop/utils/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool emailError = false;
  bool nameError = false;
  bool passwordError = false;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String result = '';

  Future userSignUp({required UserModel user}) async {
    isLoading = true;
    result = '';
    nameError = user.name.isEmpty;
    emailError = user.email.isEmpty;
    passwordError = user.password!.isEmpty;

    if (nameError || emailError || passwordError) {
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      UserModel(
        email: user.email,
        name: user.name,
        password: '',
        uid: userCredential.user?.uid,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'name': user.name,
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Preferences().initialize().then((_) {
        Preferences().setUid(userCredential.user?.uid);
      });

      result = 'success';
    } on FirebaseAuthException catch (e) {
      result = e.code;
    } catch (e) {
      print('Error occurred: $e');
      result = e.toString();
      return;
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return result;
  }

  Future userSignIn({required UserModel user}) async {
    isLoading = true;
    result = '';
    emailError = !emailRegex.hasMatch(user.email) || user.email.isEmpty;
    passwordError = user.password!.isEmpty;

    if (!emailError || !passwordError) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password!,
        );

        UserModel(
          email: user.email,
          name: user.name,
          password: '',
          uid: userCredential.user?.uid,
        );

        print(userCredential.user?.email);
        Preferences().initialize().then((_) {
          Preferences().setUid(userCredential.user?.uid);
        });

        result = 'success';
      } on FirebaseAuthException catch (e) {
        result = e.code;
      } catch (e) {
        result = e.toString();
      } finally {
        isLoading = false;
        notifyListeners();
      }

      return result;
    }
  }

  Future logout() async {
    isLoading = true;
    result = '';
    try {
      await _auth.signOut();
      result = 'success';

      Preferences().initialize().then((_) {
        Preferences().clearSharedPrefs();
      });
    } catch (e) {
      print('Error occurred during logout: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return result;
  }
}
