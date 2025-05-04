import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 64),
            Center(child: Image.asset('assets/images/logo.png')),
            SizedBox(height: 16),
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF41424F),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Sign in to continue to your account",
              style: TextStyle(fontSize: 16, color: Color(0xFF707480)),
            ),
            SizedBox(height: 24),
            Image.asset(
              'assets/images/ic_art.jpg',
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Image.asset(
                'assets/images/google_logo.png',
                height: 20.0,
                width: 20.0,
              ),
              label: Text(
                'Continue with Gmail',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: controller.continueWithGmail,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Image.asset(
                'assets/images/ic_phone.png',
                height: 20.0,
                width: 20.0,
              ),
              label: Text(
                'Login with Phone Number',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: controller.loginWithPhoneNumber,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
