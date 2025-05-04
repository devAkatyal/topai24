import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';

class HomeController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController additionalInfoController;

  final List<int> ageOptions = List<int>.generate(83, (i) => i + 18);
  final RxnInt selectedAge = RxnInt(null);

  final RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    additionalInfoController = TextEditingController();
    addressController.clear();
    phoneController.clear();
    additionalInfoController.clear();
    _loadExistingData();
  }

  @override
  void onClose() {
    addressController.dispose();
    phoneController.dispose();
    additionalInfoController.dispose();
    super.onClose();
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? validateAge(int? value) {
    if (value == null) {
      return 'Please select your age';
    }
    return null;
  }

  Future<void> saveInformation() async {
    FocusScope.of(Get.context!).unfocus();

    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Please fix the errors in the form',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
      return;
    }

    if (isLoading.value) return;
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      Get.snackbar(
        'Error',
        'User not logged in. Please log in again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    isLoading.value = true;

    final Map<String, dynamic> userData = {
      'address': addressController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'age': selectedAge.value,
      'additionalInfo': additionalInfoController.text.trim(),
      'profileLastUpdated': FieldValue.serverTimestamp(),
    };

    try {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .set(userData, SetOptions(merge: true));

      Get.snackbar(
        'Success',
        'Your information has been saved.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save information: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _loadExistingData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnap = await _firestore.collection('users').doc(user.uid).get();
      if (docSnap.exists && docSnap.data() != null) {
        final data = docSnap.data()!;
        addressController.text = data['address'] ?? '';
        phoneController.text = data['phoneNumber'] ?? '';
        selectedAge.value = data['age'];
        additionalInfoController.text = data['additionalInfo'] ?? '';
      }
    }
  }

  void continueToLogout() {
    FocusScope.of(Get.context!).unfocus();
    Get.toNamed(Routes.LOGOUT);
  }

  void continueToDeleteData() {
    FocusScope.of(Get.context!).unfocus();
    Get.toNamed(Routes.DELETE_DATA);
  }

  Future<void> deleteUserData() async {
    isLoading.value = true;
    errorMessage.value = '';

    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      errorMessage.value = "Error: No user is currently logged in.";
      isLoading.value = false;
      _showErrorSnackbar(errorMessage.value);
      print(errorMessage.value);
      return;
    }

    final String uid = currentUser.uid;

    final DocumentReference userDocRef = _firestore
        .collection('users')
        .doc(uid);

    try {
      await userDocRef.delete();
      Get.snackbar(
        'Data Deletion Successful',
        'User data deleted!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      );

      try {
        final LoginController loginController = Get.find<LoginController>();
        await loginController.logout();
      } catch (e) {
        errorMessage.value =
            "Data deleted, but failed to trigger automatic logout. Please logout manually.";
        _showErrorSnackbar(errorMessage.value);
      }
    } on FirebaseException catch (e) {
      errorMessage.value =
          "Firestore Error: ${e.message ?? 'Unknown Firestore error'} (Code: ${e.code})";
      _showErrorSnackbar(errorMessage.value);
    } catch (e) {
      errorMessage.value = "An unexpected error occurred: $e";
      _showErrorSnackbar(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      'Deletion Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 4),
    );
  }
}
