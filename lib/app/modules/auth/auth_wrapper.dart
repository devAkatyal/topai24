import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/login/controllers/login_controller.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    // Use ever() to listen reactively and navigate
    ever(loginController.firebaseUser, _handleAuthChanged);
    // Initial check in case the stream has already emitted
    _handleAuthChanged(loginController.firebaseUser.value);
  }

  void _handleAuthChanged(User? user) {
    // Use addPostFrameCallback to ensure navigation happens after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Check if the widget is still in the tree

      final currentRoute = Get.currentRoute;
      if (user == null) {
        if (currentRoute != '/login') {
          Get.offAllNamed('/login');
        }
      } else {
        if (currentRoute != '/profile') {
          Get.offAllNamed('/profile');
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
