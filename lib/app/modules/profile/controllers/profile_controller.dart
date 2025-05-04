import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final RxnString name = RxnString(null);
  final RxnString email = RxnString(null);
  final RxnString userId = RxnString(null);
  final RxnString photoUrl = RxnString(null);

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() async {
    isLoading.value = true;
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        name.value = currentUser.displayName;
        email.value = currentUser.email;
        userId.value = currentUser.uid;
        photoUrl.value = currentUser.photoURL;
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not load user profile: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
      Get.offAllNamed(Routes.LOGIN);
    } finally {
      isLoading.value = false;
    }
  }

  void continueToHome() {
    Get.toNamed(Routes.HOME);
  }
}
