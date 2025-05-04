import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RxBool isLoading = false.obs;
  final Rxn<User> firebaseUser = Rxn<User>();
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  bool get isLoggedIn => firebaseUser.value != null;

  Future<void> continueWithGmail() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        errorMessage.value = 'Google Sign-In cancelled by user.';
        isLoading.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      Get.snackbar(
        'Login Successful',
        'Welcome ${userCredential.user?.displayName ?? 'User'}!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );

      Get.offAllNamed(Routes.PROFILE);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = 'Login failed: ${e.message ?? 'Unknown error'}';
      Get.snackbar(
        'Login Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred during login.';
      Get.snackbar(
        'Login Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithPhoneNumber() {
    Get.snackbar(
      'Login with phone',
      'Not Implemented yet..',
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar(
        'Logout Successful',
        'User logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    } catch (e) {
      errorMessage.value = 'An error occurred during logout: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
