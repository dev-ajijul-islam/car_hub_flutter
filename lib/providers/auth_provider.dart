import 'package:car_hub/ui/widgets/show_snackbar_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool signUpInProgress = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  ///=================================sign up with email and password===========================

  Future<bool> signUpWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    signUpInProgress = true;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        debugPrint("User created: ${user.uid}");
        showSnackbarMessage(context: context, message: "Sign up successful",color: Colors.green);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      debugPrint("Firebase error: ${e.code}");
      showSnackbarMessage(context: context, message: e.message.toString(),color: Colors.red);
      return false;
    } catch (e) {
      debugPrint("Unknown error: $e");
      showSnackbarMessage(context: context, message: e.toString(),color: Colors.red);
      return false;
    } finally {
      signUpInProgress = false;
      notifyListeners();
    }
  }

///=================================sign in with email and password===========================



}
